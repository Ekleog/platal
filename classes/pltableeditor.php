<?php
/***************************************************************************
 *  Copyright (C) 2003-2010 Polytechnique.org                              *
 *  http://opensource.polytechnique.org/                                   *
 *                                                                         *
 *  This program is free software; you can redistribute it and/or modify   *
 *  it under the terms of the GNU General Public License as published by   *
 *  the Free Software Foundation; either version 2 of the License, or      *
 *  (at your option) any later version.                                    *
 *                                                                         *
 *  This program is distributed in the hope that it will be useful,        *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of         *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          *
 *  GNU General Public License for more details.                           *
 *                                                                         *
 *  You should have received a copy of the GNU General Public License      *
 *  along with this program; if not, write to the Free Software            *
 *  Foundation, Inc.,                                                      *
 *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA                *
 ***************************************************************************/

class PLTableEditor
{
    // the plat/al name of the page
    public $pl;
    // the table name
    public $table;
    // joint tables to delete when deleting an entry
    public $jtables = array();
    /** joint tables to add optional infos
     * associative array : keys are the tables names, values are the joint
     * clauses
     * @see add_option_fields
     */
    public $otables = array();
    /** optional fields
     * These fields are used to display additionnal infos in listing (an only
     * there). The additionnal infos are retreived from other tables. This var
     * is an associative array : keys are the sql name of the fields
     * (table.field) where table must be in $otables, values are a list of the
     * name used in $vars, the description and the type of the field.
     */
    public $ofields = array();
    // sorting field
    public $sort = array();
    // the id field
    public $idfield;
    // possibility to edit the field
    public $idfield_editable;
    // vars
    public $vars;
    // number of displayed fields
    public $nbfields;
    // a where clause to restrict table
    public $whereclause;
    // the field for sorting entries
    public $sortfield;
    public $sortdesc = false;
    // action to do to delete row:
    // null => delete effectively, false => no deletion, SQL
    public $delete_action;
    public $delete_message;
    // Should "Save" button return to the list view
    public $auto_return = true;

    /* table editor for platal
     * $plname : the PLname of the page, ex: admin/payments
     * $table : the table to edit, ex: profile_medals
     * $idfield : the field of the table which is the id, ex: id
     * $editid : is the id editable or not (if not, it is considered as an int)
     */
    public function __construct($plname, $table, $idfield, $editid=false)
    {
        $this->pl = $plname;
        $this->table = $table;
        $this->idfield = $idfield;
        $this->sortfield = $idfield;
        $this->idfield_editable = $editid;
        $this->whereclause = '1';
        $r = XDB::iterator("SHOW FULL COLUMNS FROM $table");
        $this->vars = array();
        while ($a = $r->next()) {
            // desc will be the title of the column
            $a['desc'] = $a['Field'];
            $a['display'] = true;

            if (substr($a['Type'],0,8) == 'varchar(') {
                // limit editing box size
                $a['Size'] = $a['Maxlength'] = substr($a['Type'], 8, strlen($a['Type']) - 9);
                if ($a['Size'] > 40) $a['Size'] = 40;
                // if too big, put a textarea
                $a['Type'] = ($a['Maxlength']<200)?'varchar':'varchar200';
            }
            elseif ($a['Type'] == 'text' || $a['Type'] == 'mediumtext')
                $a['Type'] = 'textarea';
            elseif (substr($a['Type'],0,4) == 'set(') {
                // get the list of options
                $a['List'] = explode('§',str_replace("','","§",substr($a['Type'], 5, strlen($a['Type']) - 7)));
                if (count($a['List']) == 1) {
                    $a['Type'] = 'checkbox';
                    $a['Value'] = $a['List'][0];
                } else {
                    $a['Type'] = 'set';
                }
            }
            elseif (substr($a['Type'],0,5) == 'enum(') {
                // get the list of options
                $a['List'] = explode('§',str_replace("','","§",substr($a['Type'], 6, strlen($a['Type']) - 8)));
                $a['Type'] = 'enum';
            }
            elseif (substr($a['Type'],0,10) == 'timestamp(' || $a['Type'] == 'datetime') {
                $a['Type'] = 'timestamp';
            }
            elseif ($a['Comment'] == 'ip_address') {
                $a['Type']='ip_address';
            }

            $this->vars[$a['Field']] = $a;
        }
        $this->vars[$idfield]['desc'] = 'id';
    }

    // called before creating a new entry
    private function prepare_new()
    {
        $entry = array();
        foreach ($this->vars as $field => $descr) {
            $entry[$field] = $descr['Default'];
        }
        return $this->prepare_edit($entry);
    }

    // called before editing $entry
    private function prepare_edit(&$entry)
    {
        foreach ($this->vars as $field => $descr) {
            if ($descr['Type'] == 'set') {
                // get the list of options selected
                $selected = explode(',', $entry[$field]);
                $entry[$field] = array();
                foreach ($selected as $option)
                    $entry[$field][$option] = 1;
            }
            if ($descr['Type'] == 'timestamp') {
                // set readable timestamp
                $date =& $entry[$field];
                $date = preg_replace('/([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})/', '\3/\2/\1 \4:\5:\6', $date);
            }
            if ($descr['Type'] == 'date') {
                $date =& $entry[$field];
                $date = preg_replace('/([0-9]{4})-?([0-9]{2})-?([0-9]{2})/', '\3/\2/\1', $date);
            }
            if ($descr['Type'] == 'ip_address') {
                $ip = & $entry[$field];
                $ip = long2ip($ip);
            }
        }
        return $entry;
    }

    // set whether the save button show redirect to list view or edit view
    public function list_on_edit($var)
    {
        $this->auto_return = $var;
    }

    // change display of a field
    public function describe($name, $desc, $display)
    {
        $this->vars[$name]['desc'] = $desc;
        $this->vars[$name]['display'] = $display;
    }

    // add a join table, when deleting a row corresponding entries will be deleted in these tables
    public function add_join_table($name,$joinid,$joindel,$joinextra="")
    {
        if ($joindel)
            $this->jtables[$name] = array("joinid" => $joinid,"joinextra" => $joinextra?(" AND ".$joinextra):"");
    }

    /** Add optional table
     * @see add_option_field
     * @param $name the table sql name
     * @param $jointclause the full joint clause. Use t as main table alias
     * name.
     */
    public function add_option_table($name, $jointclause)
    {
        $this->otables[$name] = $jointclause;
    }

    /** Add optional field
     * These fields are used to display additionnal infos in listing (and only
     * there). The additionnal infos are retreived from other tables.
     * @param $sqlname is the full sql name (table.field) where table must be
     * added with add_option_table
     * @param $name the name used for sort (please make it different from
     * other fields in main table or subtables)
     * @param $desc the description displayed as column header
     * @param $type the typed used for display
     */
    public function add_option_field($sqlname, $name, $desc, $type)
    {
        $this->ofields[$sqlname] = array($name, $desc, $type);
    }

    // add a sort key
    public function add_sort_field($key, $desc = false, $default = false)
    {
        if ($default) {
            $this->sortfield = $key . ($desc ? ' DESC' : '');
        } else {
            $this->sort[] = $key . ($desc ? ' DESC' : '');
        }
    }

    // add a where clause to limit table listing
    public function set_where_clause($whereclause="1")
    {
        $this->whereclause = $whereclause;
    }
    
    // set an action when trying to delete row
    public function on_delete($action = NULL, $message = NULL)
    {
        $this->delete_action = $action;
        $this->delete_message = $message;
    }

    // call when done
    public function apply(PlPage &$page, $action, $id = false)
    {
        $page->coreTpl('table-editor.tpl');
        $list = true;
        if ($action == 'delete' && $id !== false) {
            S::assert_xsrf_token();

            if (!isset($this->delete_action)) {
                foreach ($this->jtables as $table => $j)
                    XDB::execute("DELETE FROM {$table} WHERE {$j['joinid']} = {?}{$j['joinextra']}", $id);
                XDB::execute("DELETE FROM {$this->table} WHERE {$this->idfield} = {?}",$id);
                $page->trigSuccess("L'entrée ".$id." a été supprimée.");
            } else if ($this->delete_action) {
                XDB::execute($this->delete_action, $id);
                if (isset($this->delete_message)) {
                    $page->trigSuccess($this->delete_message);
                } else {
                    $page->trigSuccess("L'entrée ".$id." a été supprimée.");
                }
            } else {
                $page->trigError("Impossible de supprimer l'entrée.");
            }
        }
        if ($action == 'edit' && $id !== false) {
            $r = XDB::query("SELECT * FROM {$this->table} WHERE {$this->idfield} = {?} AND {$this->whereclause}",$id);
            $entry = $r->fetchOneAssoc();
            $page->assign('entry', $this->prepare_edit($entry));
            $page->assign('id', $id);
            $list = false;
        }
        if ($action == 'massadd') {
            $importer = new CSVImporter($this->table, $this->idfield_editable ? $this->idfield : null);
            $fields   = array();
            foreach ($this->vars as $field=>$descr) {
                if ($this->idfield_editable || $field != $this->idfield) {
                    $fields[] = $field;
                    $importer->describe($field, @$descr['desc']);
                }
            }
            $page->assign('massadd', true);
            $importer->apply($page, $this->pl . '/massadd', $fields);
            $list = false;
        }
        if ($action == 'new') {
            if (!$this->idfield_editable) {
                $page->assign('entry', $this->prepare_new());
            }
            $list = false;
        }
        if ($action == 'update') {
            S::assert_xsrf_token();

            $values = "";
            $cancel = false;
            foreach ($this->vars as $field => $descr) {
                if ($values) $values .= ',';
                if (($field == $this->idfield) && !$this->idfield_editable) {
                    if ($id === false || $id === null) {
                        $val = "'".addslashes(XDB::fetchOneCell("SELECT MAX( {$field} ) + 1 FROM {$this->table}"))."'";
                    } else {
                        $val = "'".addslashes($id)."'";
                    }
                } elseif ($descr['Type'] == 'set') {
                    $val = "";
                    if (Post::has($field)) foreach (Post::v($field) as $option) {
                        if ($val) $val .= ',';
                        $val .= $option;
                    }
                    $val = "'".addslashes($val)."'";
                } elseif ($descr['Type'] == 'checkbox') {
                    $val = Post::has($field)?"'".addslashes($descr['Value'])."'":"''";
                } elseif (Post::has($field)) {
                    $val = Post::v($field);
                    if ($descr['Type'] == 'timestamp') {
                        $val = preg_replace('/([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4}) ([0-9]{1,2}):([0-9]{1,2}):([0-9]{1,2})/', '\3\2\1\4\5\6', $val);
                    }
                    elseif ($descr['Type'] == 'date') {
                        $val = preg_replace('/([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})/', '\3-\2-\1', $val);
                    }
                    elseif ($descr['Type'] == 'ip_address') {
                        $val = ip2long($val);
                    }
                    $val = "'".addslashes($val)."'";
                } else {
                    $cancel = true;
                    $page->trigError("Il manque le champ ".$field);
                }
                $values .= $val;
            }
            if (!$cancel) {
                if ($this->idfield_editable && $id != Post::v($this->idfield))
                    XDB::execute("UPDATE {$this->table} SET {$this->idfield} = {?} WHERE {$this->idfield} = {?} AND {$this->whereclause}", Post::v($this->idfield), $id);
                XDB::execute("REPLACE INTO {$this->table} VALUES ($values)");
                if ($id !== false && $id !== null) {
                    $page->trigSuccess("L'entrée ".$id." a été mise à jour.");
                } else {
                    $page->trigSuccess("Une nouvelle entrée a été créée.");
                    $id = XDB::insertId();
                }
            } else
                $page->trigError("Impossible de mettre à jour.");
            if (!$this->auto_return) {
                return $this->apply($page, 'edit', $id);
            }
        }
        if ($action == 'sort') {
            $this->sortfield = $id;
        }
        if ($action == 'sortdesc') {
            $this->sortfield = $id.' DESC';
        }
        if ($list) {
            // user can sort by field by clicking the title of the column
            if (isset($this->sortfield)) {
                // add this sort order after the others (chosen by dev)
                $this->add_sort_field($this->sortfield);
                if (substr($this->sortfield,-5) == ' DESC') {
                    $this->sortfield = substr($this->sortfield,0,-5);
                    $this->sortdesc = true;
                }
            }
            if (count($this->sort) > 0) {
                $sort = 'ORDER BY ' . join($this->sort, ',');
            }
            // optional infos columns
            $optional_fields = '';
            foreach ($this->ofields as $sqlname => $ofieldvalues) {
                list($aliasname, $desc, $type) = $ofieldvalues;
                $optional_fields .= ', '.$sqlname.' AS '.$aliasname;
                $this->describe($aliasname, $desc, true);
                $this->vars[$aliasname]['optional'] = true;
                $this->vars[$aliasname]['Type'] = $type;
                $this->vars[$aliasname]['Field'] = $aliasname;
            }
            $optional_joints = '';
            foreach ($this->otables as $tablename => $jointclause) {
                $optional_joints .= ' LEFT JOIN '.$tablename.' ON ('.$jointclause.')';
            }
            $it = XDB::iterator("SELECT t.* {$optional_fields} FROM {$this->table} AS t {$optional_joints} WHERE {$this->whereclause} $sort");
            $this->nbfields = 0;
            foreach ($this->vars as $field => $descr)
                if ($descr['display']) $this->nbfields++;
            $page->assign('list', $it);
        }
        $page->assign('t', $this);
    }
}

// vim:set et sw=4 sts=4 sws=4 foldmethod=marker enc=utf-8:
?>
