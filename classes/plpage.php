<?php
/***************************************************************************
 *  Copyright (C) 2003-2008 Polytechnique.org                              *
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

require_once 'smarty/libs/Smarty.class.php';

abstract class PlPage extends Smarty
{
    private $_page_type;
    private $_tpl;
    private $_errors;
    private $_failure;
    private $_jsonVars;

    // {{{ function PlPage()

    public function __construct()
    {
        parent::Smarty();

        global $globals;

        $this->caching       = false;
        $this->config_overwrite = false;
        $this->use_sub_dirs  = false;
        $this->template_dir  = $globals->spoolroot . '/templates/';
        $this->compile_dir   = $globals->spoolroot . '/spool/templates_c/';
        array_unshift($this->plugins_dir,
                      $globals->spoolroot . '/core/plugins/',
                      $globals->spoolroot . '/plugins/');
        $this->config_dir    = $globals->spoolroot . '/configs/';

        $this->compile_check = !empty($globals->debug);

        $this->_errors    = array('errors' => array());
        $this->_jsonVars  = array();
        $this->_failure   = false;

        if ($globals->mode != 'rw') {
            $this->trigError("En raison d'une maintenance, une partie des fonctionnalités du site sont"
                             . " actuellement désactivée, en particuliers aucune donnée ne sera sauvegardée");
        }
        $this->register_prefilter('at_to_globals');
        $this->addJsLink('xorg.js');
        $this->addJsLink('jquery.js');
    }

    // }}}
    // {{{ function changeTpl()

    public function changeTpl($tpl, $type = SKINNED)
    {
        $this->_tpl       = $tpl;
        $this->_page_type = $type;
        $this->assign('pl_tpl', $tpl);
    }

    // }}}
    // {{{ function raw()

    public function raw()
    {
        global $globals;
        $this->assign('globals', $globals);
        return $this->fetch($this->_tpl);
    }

    // }}}
    // {{{ function _run()

    protected function _run($skin)
    {
        global $globals, $TIME_BEGIN;

        Platal::session()->close();

        $this->register_prefilter('trimwhitespace');
        $this->register_prefilter('form_force_encodings');
        $this->register_prefilter('wiki_include');
        $this->register_prefilter('if_has_perms');
        $this->assign('pl_triggers', $this->_errors);
        $this->assign('pl_errors', $this->nb_errs());
        $this->assign('pl_failure', $this->_failure);
        $this->assign_by_ref('globals', $globals);

        if (Env::has('json') && count($this->_jsonVars)) {
            return $this->jsonDisplay();
        }

        if (Env::v('display') == 'light') {
            $this->_page_type = SIMPLE;
        } elseif (Env::v('display') == 'raw') {
            $this->_page_type = NO_SKIN;
        } elseif (Env::v('display') == 'full') {
            $this->_page_typ = SKINNED;
        }

        switch ($this->_page_type) {
          case NO_SKIN:
            if (!($globals->debug & DEBUG_SMARTY)) {
                error_reporting(0);
            }
            $this->display($this->_tpl);
            exit;

          case SIMPLE:
            $this->assign('simple', true);

          case SKINNED:
            $this->register_modifier('escape_html', 'escape_html');
            $this->default_modifiers = Array('@escape_html');
        }
        if (S::i('auth') <= AUTH_PUBLIC) {
            $this->register_outputfilter('hide_emails');
        }
        $this->addJsLink('wiki.js');
        header("Accept-Charset: utf-8");
        if (Env::v('forceXml')) {
            header("Content-Type: text/xml; charset=utf-8");
        }

        if (!$globals->debug) {
            error_reporting(0);
            $this->display($skin);
            exit;
        }

        $this->assign('validate', true);
        if (!($globals->debug & DEBUG_SMARTY)) {
            error_reporting(0);
        }
        $START_SMARTY = microtime(true);
        $result = $this->fetch($skin);
        $ttime  = sprintf('Temps total: %.02fs (Smarty %.02fs) - Mémoire totale : %dKo<br />',
                          microtime(true) - $TIME_BEGIN, microtime(true) - $START_SMARTY,
                          memory_get_peak_usage(true) / 1024);
        if ($globals->debug & DEBUG_BT) {
            PlBacktrace::clean();
            $this->assign_by_ref('backtraces', PlBacktrace::$bt);
            $result = str_replace('@@BACKTRACE@@', $this->fetch('skin/common.backtrace.tpl'), $result);
        } else {
            $result = str_replace('@@BACKTRACE@@', '', $result);
        }

        $replc  = "<span class='erreur'>VALIDATION HTML INACTIVE</span><br />";
        if ($globals->debug & DEBUG_VALID) {
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

    abstract public function run();

    // }}}
    // {{{ function nb_errs()

    public function nb_errs()
    {
        return count($this->_errors['errors']);
    }

    // }}}
    // {{{ function trig()

    private function trig($msg, $type = 'errors')
    {
        if (!isset($this->_errors[$type])) {
            $this->_errors[$type] = array();
        }
        $this->_errors[$type][] = $msg;
    }

    public function trigError($msg)
    {
        $this->trig($msg, 'errors');
    }

    public function trigWarning($msg)
    {
        $this->trig($msg, 'warnings');
    }

    public function trigSuccess($msg)
    {
        $this->trig($msg, 'success');
    }

    // }}}
    // {{{ function kill()

    public function kill($msg)
    {
        // PHP is used on command line... do not run the whole page stuff.
        if (php_sapi_name() == 'cli') {
            echo $msg . "\n";
            exit;
        }

        global $platal;

        $this->assign('platal', $platal);
        $this->trigError($msg);
        $this->_failure = true;
        $this->run();
    }

    // }}}
    // {{{ function setTitle

    public function setTitle($title)
    {
        global $globals;
        if (isset($globals->core->sitename)) {
            $title = $globals->core->sitename . ' :: ' . $title;
        }
        $this->assign('pl_title', $title);
    }

    // }}}
    // {{{ function addJsLink

    public function addJsLink($path)
    {
        $this->append('pl_js', $path);
    }

    // }}}
    // {{{ function addCssLink

    public function addCssLink($path)
    {
        $this->append('pl_css', $path);
    }

    // }}}
    // {{{ function addCssInline

    public function addCssInline($css)
    {
        if (!empty($css)) {
            $this->append('pl_inline_css', $css);
        }
    }

    // }}}
    // {{{ function setRssLink

    public function setRssLink($title, $path)
    {
        $this->assign('pl_rss', array('title' => $title, 'href' => $path));
    }

    // }}}
    // {{{ function jsonDisplay
    protected function jsonDisplay()
    {
        header("Content-type: text/javascript; charset=utf-8");
        array_walk_recursive($this->_jsonVars, "escape_xorgDB");
        $jsonbegin = Env::v('jsonBegin');
        $jsonend = Env::v('jsonEnd');
        if (Env::has('jsonVar')) {
            $jsonbegin = Env::v('jsonVar').' = ';
            $jsonend = ';';
        } elseif (Env::has('jsonFunc')) {
            $jsonbegin = Env::v('jsonFunc').'(';
            $jsonend = ');';
        }
        echo $jsonbegin, json_encode($this->_jsonVars), $jsonend;
        exit;
    }
    // }}}
    // {{{ function jsonAssign
    public function jsonAssign($var, $value)
    {
        $this->_jsonVars[$var] = $value;
    }

    // }}}
}

function escape_xorgDB(&$item, $key)
{
    if (is_a($item, 'XOrgDBIterator')) {
        $expanded = array();
        while ($a = $item->next()) {
            $expanded[] = $a;
        }
        $item = $expanded;
    }
}

// {{{ function escape_html ()

/**
 * default smarty plugin, used to auto-escape dangerous html.
 *
 * < --> &lt;
 * > --> &gt;
 * " --> &quot;
 * & not followed by some entity --> &amp;
 */
function escape_html($string)
{
    if (is_string($string)) {
        return htmlspecialchars($string, ENT_QUOTES, 'UTF-8');
    } else {
        return $string;
    }
}

// }}}
// {{{ function at_to_globals()

/**
 * helper
 */

function _to_globals($s) {
    global $globals;
    $t = explode('.',$s);
    if (count($t) == 1) {
        return var_export($globals->$t[0],true);
    } else {
        return var_export($globals->$t[0]->$t[1],true);
    }
}

/**
 * compilation plugin used to import $globals confing through #globals.foo.bar# directives
 */

function at_to_globals($tpl_source, &$smarty)
{
    return preg_replace('/#globals\.([a-zA-Z0-9_.]+?)#/e', '_to_globals(\'\\1\')', $tpl_source);
                        }

                        // }}}
                        // {{{  function trimwhitespace

                        function trimwhitespace($source, &$smarty)
                        {
                        $tags = '(script|pre|textarea)';
                        preg_match_all("!<$tags.*?>.*?</(\\1)>!ius", $source, $tagsmatches);
                        $source = preg_replace("!<$tags.*?>.*?</(\\1)>!ius", "&&&tags&&&", $source);

                        // remove all leading spaces, tabs and carriage returns NOT
                        // preceeded by a php close tag.
                        $source = preg_replace('/((?<!\?>)\n)[\s]+/m', '\1', $source);
                        $source = preg_replace("!&&&tags&&&!e",  'array_shift($tagsmatches[0])', $source);

                        return $source;
                        }

                        // }}}
                        // {{{ function wiki_include

function wiki_include($source, &$smarty)
{
    return preg_replace('/\{include( [^}]*)? wiki=([^} ]+)(.*?)\}/ui',
                        '{include\1 file="../spool/wiki.d/cache_\2.tpl"\3 included=1}',
                        $source);
}

// }}}
//{{{ function hasPerm

function if_has_perms($source, &$smarty)
{
    $source = preg_replace('/\{if([^}]*) (\!?)hasPerms\(([^)]+)\)([^}]*)\}/',
    '{if\1 \2$smarty.session.perms->hasFlagCombination(\3)\4}',
    $source);
return preg_replace('/\{if([^}]*) (\!?)hasPerm\(([^)]+)\)([^}]*)\}/',
       '{if\1 \2($smarty.session.perms && $smarty.session.perms->hasFlag(\3))\4}',
       $source);
}

// }}}
// {{{

function form_force_encodings($source, &$smarty)
{
    return preg_replace('/<form[^\w]/',
                        '\0 accept-charset="utf-8" ',
                        $source);
}

// }}}
// {{{ function hide_emails

function _hide_email($source)
{
    $source = str_replace("\n", '', $source);
    return '<script type="text/javascript">//<![CDATA[' . "\n" .
        'Nix.decode("' . addslashes(str_rot13($source)) . '");' . "\n" .
        '//]]></script>';
}

function hide_emails($source, &$smarty)
{
    if (!strpos($source, '@')) {
        return $source;
    }

    //prevent email replacement in <script> and <textarea>
    $tags = '(script|textarea|select)';
    preg_match_all("!<$tags.*?>.*?</(\\1)>!ius", $source, $tagsmatches);
    $source = preg_replace("!<$tags.*?>.*?</(\\1)>!ius", "&&&tags&&&", $source);

    //catch all emails in <a href="mailto:...">
    preg_match_all("!<a[^>]+href=[\"'][^\"']*[-a-z0-9+_.]+@[-a-z0-9_.]+[^\"']*[\"'].*?>.*?</a>!ius", $source, $ahref);
    $source = preg_replace("!<a[^>]+href=[\"'][^\"']*[-a-z0-9+_.]+@[-a-z0-9_.]+[^\"']*[\"'].*?>.*?</a>!ius", '&&&ahref&&&', $source);

    //prevant replacement in tag attributes
    preg_match_all("!<[^>]+[-a-z0-9_+.]+@[-a-z0-9_.]+.+?>!ius", $source, $misc);
    $source = preg_replace("!<[^>]+[-a-z0-9_+.]+@[-a-z0-9_.]+.+?>!ius", '&&&misc&&&', $source);

    //catch !
    $source = preg_replace('!([-a-z0-9_+.]+@[-a-z0-9_.]+)!iue', '_hide_email("\1")', $source);
    $source = preg_replace('!&&&ahref&&&!e', '_hide_email(array_shift($ahref[0]))', $source);

    // restore data
    $source = preg_replace('!&&&misc&&&!e', 'array_shift($misc[0])', $source);
    $source = preg_replace("!&&&tags&&&!e",  'array_shift($tagsmatches[0])', $source);

    return $source;
}

// }}}

// vim:set et sw=4 sts=4 sws=4 foldmethod=marker enc=utf-8:
?>