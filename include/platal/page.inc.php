<?php
/***************************************************************************
 *  Copyright (C) 2003-2004 Polytechnique.org                              *
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

require_once('diogenes/diogenes.core.page.inc.php');
require_once('platal/errors.inc.php');
require_once('platal/smarty.plugins.inc.php');

// {{{ class PlatalPage

class PlatalPage extends DiogenesCorePage
{
    // {{{ properties
    
    var $_page_type;
    var $_tpl;
    var $_errors;

    // defaults
    var $caching          = false;
    var $config_overwrite = false;
    var $use_sub_dirs     = false;

    // }}}
    // {{{ function PlatalPage()

    function PlatalPage($tpl, $type=SKINNED)
    {
        global $globals;

        $this->template_dir  = $globals->spoolroot."/templates/";
        $this->compile_dir   = $globals->spoolroot."/templates_c/";
        array_unshift($this->plugins_dir, $globals->spoolroot."/plugins/");
        $this->config_dir    = $globals->spoolroot."/configs/";

        $this->compile_check = !empty($globals->debug);

        if ($type == SKINNED) {
            $this->register_modifier('escape_html', 'escape_html');
            $this->default_modifiers[] = '@escape_html';
        }

        $this->_page_type = $type;
        $this->_tpl       = $tpl;
        $this->_errors    = new XOrgErrors;

        $this->DiogenesCorePage();
        $this->register_prefilter('at_to_globals');
        $this->register_prefilter('trimwhitespace');
        $this->addJsLink('javascript/xorg.js');

        $this->doAuth();
    }

    // }}}
    // {{{ function changeTpl()

    function changeTpl($tpl, $type=SKINNED)
    {
	$this->_tpl       = $tpl;
	$this->_page_type = $type;
	if ($type == SKINNED) {
	    $this->register_modifier('escape_html', 'escape_html');
	    $this->default_modifiers = Array('@escape_html');
	}

        $this->_page_type = $type;
	$this->assign('xorg_tpl', $tpl);
    }

    // }}}
    // {{{ function _run()

    function _run($skin)
    {
        global $globals, $TIME_BEGIN;
        $this->assign("xorg_error", $this->_errors);
        
        if ($this->_page_type == NO_SKIN) {
            $this->display($this->_tpl);
            exit;
        }
        
        if ($globals->debug) {

            if ($globals->debug & 1) {
                $this->assign('db_trace', $globals->db->trace_format($this, 'database-debug.tpl'));
            }

            $this->assign('validate', urlencode($globals->baseurl.'/valid.html'));
            $result = $this->fetch($skin);
            $ttime  = sprintf('Temps total: %.02fs<br />', microtime_float() - $TIME_BEGIN);
            $replc  = "<span class='erreur'>VALIDATION HTML INACTIVE</span><br />";

            if ($globals->debug & 2) {

                $fd = fopen($this->compile_dir."/valid.html","w");
                fwrite($fd, $result);
                fclose($fd);
	
                exec($globals->spoolroot."/bin/devel/xhtml.validate.pl ".$this->compile_dir."/valid.html", $val);
                foreach ($val as $h) {
                    if (preg_match("/^X-W3C-Validator-Errors: (\d+)$/", $h, $m)) {
                        $replc = '<span style="color: #080;">HTML OK</span><br />';
                        if ($m[1]) {
                            $replc = "<span class='erreur'><a href='http://validator.w3.org/check?uri={$globals->baseurl}"
                                ."/valid.html&amp;ss=1#result'>{$m[1]} ERREUR(S) !!!</a></span><br />";
                        }
                        break;
                    }
                }
            }

            echo str_replace("@HOOK@", $ttime.$replc, $result);
            exit;
        }

        $this->display($skin);
        exit;
    }

    // }}}
    // {{{ function run()

    function run()
    {
        die ("implement me");
    }

    // }}}
    // {{{ function nb_errs()

    function nb_errs()
    {
        return count($this->_errors->errs);
    }

    // }}}
    // {{{ function trig()

    function trig($msg)
    {
        $this->_errors->trig($msg);
    }

    // }}}
    // {{{ function trig()

    function trig_run($msg)
    {
        $this->_errors->trig($msg);
        $this->run();
    }

    // }}}
    // {{{ function fail()

    function fail($msg)
    {
        $this->_errors->fail($msg);
    }

    // }}}
    // {{{ function kill()

    function kill($msg)
    {
        $this->fail($msg);
        $this->run();
    }

    // }}}
    // {{{ function doAuth()

    function doAuth() { }
    
    // }}}
    // {{{ function loadModule()
    
    function loadModule($modname)
    {
        require_once("$modname.inc.php");
    }

    // }}}
    // {{{ function addJsLink

    function addJsLink($path)
    {
        $this->append('xorg_js', $path);
    }

    // }}}
    // {{{ function addCssLink

    function addCssLink($path)
    {
        $this->append('xorg_css', $path);
    }

    // }}}
    // {{{ function gassign
    
    function gassign($varname)
    {
        global $$varname;
        $this->assign($varname, $$varname);
    }

    // }}}
}

// }}}

// vim:set et sw=4 sts=4 sws=4 foldmethod=marker:
?>