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

var is_netscape = (navigator.appName.substring(0,8) == "Netscape");
var is_IE       = (navigator.appName.substring(0,9) == "Microsoft");

// {{{ function getNow()

function getNow() {
    dt = new Date();
    dy = dt.getDay();
    mh = dt.getMonth();
    wd = dt.getDate();
    yr = dt.getYear();
    if (yr<1000) yr += 1900;
    hr = dt.getHours();
    mi = dt.getMinutes();

    time   = (mi < 10) ? hr +':0'+mi : hr+':'+mi;
    days   = ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'];
    months = ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet',
           'août', 'septembre', 'octobre', 'novembre', 'décembre']

    return days[dy]+' '+wd+' '+months[mh]+' '+yr+'<br />'+time;
}

// }}}
// {{{ Search Engine

function canAddSearchEngine()
{
  if (((typeof window.sidebar == "object") && (typeof window.sidebar.addSearchEngine == "function"))
      || ((typeof window.sidebar == "object") && (typeof window.sidebar.addSearchEngine == "function"))) {
      return true;
  }
  return false;
}

function addSearchEngine()
{
  var searchURI = "http://www.polytechnique.org/xorg.opensearch.xml";
  if ((typeof window.sidebar == "object") && (typeof window.sidebar.addSearchEngine == "function")) {
    window.sidebar.addSearchEngine(
      searchURI,
      "http://www.polytechnique.org/images/xorg.png",
      "Annuaire Polytechnique.org",
      "Academic");
  } else {
    try {
        window.external.AddSearchProvider(searchURI);
    } catch(e) {
        alert("Impossible d'installer la barre de recherche");
    }
  }
}

// }}}
// {{{ dynpost()

function dynpost(action, values)
{
    var body = document.getElementsByTagName('body')[0];

    var form = document.createElement('form');
    form.action = action;
    form.method = 'post';

    body.appendChild(form);

    for (var k in values) {
        var input = document.createElement('input');
        input.type = 'hidden';
        input.name = k;
        input.value = values[k];
        form.appendChild(input);
    }

    form.submit();
}


function dynpostkv(action, k, v)
{
    var dict = {};
    dict[k] = v;
    dynpost(action, dict);
}

// }}}
// {{{ function RegExp.escape()

RegExp.escape = function(text) {
  if (!arguments.callee.sRE) {
    var specials = [
      '/', '.', '*', '+', '?', '|',
      '(', ')', '[', ']', '{', '}',
      '\\', '^' , '$'
    ];
    arguments.callee.sRE = new RegExp(
      '(\\' + specials.join('|\\') + ')', 'g'
    );
  }
  return text.replace(arguments.callee.sRE, '\\$1');
}

// }}}

/***************************************************************************
 * POPUP THINGS
 */

// {{{ function popWin()

function popWin(theNode, w, h) {
    window.open(theNode.href, '_blank',
        'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width='+w+',height='+h);
    return false;
}

// }}}
// {{{ function goodiesPopup()

function goodiesPopup(node) {
    if (node.href.indexOf('ical') > -1) {
        __goodies_popup(node, __goodies_ical_sites, 'Calendrier iCal');
    } else if (node.href.indexOf('rss') > -1 && node.href.indexOf('prefs/rss') < 0 &&  (node.href.indexOf('xml') > -1 || node.href.indexOf('hash'))) {
        __goodies_popup(node, __goodies_rss_sites, 'Fil rss');
    }
}

function disableGoodiesPopups() {
    __goodies_active = false;
}

var __goodies_active = true;
var __goodies_ical_sites = [
    {'url_prefix': '',
     'img': 'images/icons/calendar_view_day.gif',
     'title': 'Calendrier iCal'},
    {'url_prefix': 'http://www.google.com/calendar/render?cid=',
     'img': 'images/goodies/add-google-calendar.gif',
     'title': 'Ajouter à Google Calendar'},
    {'url_prefix': 'https://www.google.com/calendar/hosted/polytechnique.org/render?cid=',
     'img': 'images/goodies/add-google-calendar.gif',
     'title': 'Ajouter à Google Apps / Calendar'}
];
var __goodies_rss_sites = [
    {'url_prefix': '',
     'img': 'images/icons/feed.gif',
     'title': 'Fil rss'},
    {'url_prefix': 'http://fusion.google.com/add?feedurl=',
     'img': 'images/goodies/add-google.gif',
     'alt': 'Add to Google',
     'title': 'Ajouter à iGoogle/Google Reader'},
    {'url_prefix': 'http://www.netvibes.com/subscribe.php?url=',
     'img': 'images/goodies/add-netvibes.gif',
     'title': 'Ajouter à Netvibes'},
    {'url_prefix': 'http://add.my.yahoo.com/content?.intl=fr&url=',
     'img': 'images/goodies/add-yahoo.gif',
     'alt': 'Add to My Yahoo!',
     'title': 'Ajouter à My Yahoo!'},
    {'url_prefix': 'http://www.newsgator.com/ngs/subscriber/subext.aspx?url=',
     'img': 'images/goodies/add-newsgator.gif',
     'alt': 'Subscribe in NewsGator Online',
     'title': 'Ajouter à Newsgator'}
];

function __goodies_popupText(url, sites) {
    var text = '<div style="text-align: center; line-height: 2.2">';
    for (var site in sites) {
        var s_alt = (sites[site]["alt"] ? sites[site]["alt"] : "");
        var s_img = sites[site]["img"];
        var s_title = (sites[site]["title"] ? sites[site]["title"] : "");
        var s_url = (sites[site]["url_prefix"].length > 0 ? sites[site]["url_prefix"] + escape(url) : url);

        text += '<a href="' + s_url + '"><img src="' + s_img + '" title="' + s_title + '" alt="' + s_alt + '"></a><br />';
    }
    text += '<a href="https://www.polytechnique.org/Xorg/Goodies">Plus de bonus</a> ...</div>'
    return text;
}

function __goodies_popup(node, sites, default_title) {
    var mouseover_cb = function() {
        if (__goodies_active) {
            var rss_text = __goodies_popupText(node.href, sites);
            var rss_title = (node.title ? node.title : default_title);
            return overlib(rss_text, CAPTION, rss_title, CLOSETEXT, 'Fermer', DELAY, 800, STICKY, WIDTH, 150);
        }
    }
    var mouseout_cb = function() {
        nd();
    }

    node.onmouseover = mouseover_cb;
    node.onmouseout = mouseout_cb;
}

// }}}
// {{{ function auto_links()

function auto_links() {
    url  = document.URL;
    fqdn = url.replace(/^https?:\/\/([^\/]*)\/.*$/,'$1');
    light = (url.indexOf('display=light') > url.indexOf('?'));

    $("a,link").each(
        function(i) {
            node = $(this);
            enode = node.get(0);
            href =  enode.href;
            if(!href || node.hasClass('xdx')
               || href.indexOf('mailto:') > -1 || href.indexOf('javascript:') > -1) {
                return;
            }
            if (href.indexOf(fqdn) < 0 || node.hasClass('popup')) {
                node.click(function () { window.open(this.href); return false; });
            }
            if (href.indexOf(fqdn) > -1 && light) {
                href = href.replace(/([^\#\?]*)\??([^\#]*)(\#.*)?/, "$1?display=light&$2$3");
                enode.href = href;
            }
            if (href.indexOf('rss') > -1 || href.indexOf('ical') > -1) {
                if (href.indexOf('http') < 0) {
                    href = 'http://' + fqdn + '/' + href;
                }
                enode.href = href;
                if (enode.nodeName.toLowerCase() == 'a') {
                    goodiesPopup(enode);
                }
            }
            if(matches = (/^popup_([0-9]*)x([0-9]*)$/).exec(enode.className)) {
                var w = matches[1], h = matches[2];
                node.click(function() { return popWin(this, w, h); });
            }
        }
    );
    $('.popup2').click(function() { return popWin(this, 840, 600); });
    $('.popup3').click(function() { return popWin(this, 640, 800); });
}


// }}}


/***************************************************************************
 * Password check
 */

// {{{ function checkPassword

function getType(char) {
    if (char >= 'a' && char <= 'z') {
        return 1;
    } else if (char >= 'A' && char <= 'Z') {
        return 2;
    } else if (char >= '0' && char <= '9') {
        return 3;
    } else {
        return 4;
    }
}

function checkPassword(box, okLabel) {
    var prev = 0;
    var prop = 0;
    var pass = box.value;
    var types = Array(0, 0, 0, 0, 0);
    var firstType = true;
    for (i = 0 ; i < pass.length ; ++i) {
        type = getType(pass.charAt(i));
        if (prev != 0 && prev != type) {
            prop += 5;
        }
        prop += i;
        if (types[type] == 0 && !firstType) {
            prop += 15;
        } else {
            firstType = false;
        }
        types[type]++;
        prev = type;
    }
    if (pass.length < 6) {
        prop *= 0.75;
    }
    if (prop > 100) {
        prop = 100;
    } else if (prop < 0) {
        prop = 0;
    }
    if (prop >= 60) {
        color = "#4f4";
        bgcolor = "#050";
        ok = true;
    } else if (prop >= 40) {
        color = "#ff4";
        bgcolor = "#750";
        ok = true;
    } else {
        color = "#f20";
        bgcolor = "#700";
        ok = false;
    }
    $("#passwords_measure")
           .stop()
           .animate({ width: prop + "%",
                      backgroundColor: color
                    }, 750)
           .parent().stop()
                    .animate({ backgroundColor: bgcolor }, 750);
    var submitButton = $(":submit[@name='" + passwordprompt_submit + "']");
    if (ok && pass.length >= 6) {
        submitButton.attr("value", okLabel);
        submitButton.removeAttr("disabled");
    } else {
        submitButton.attr("value", "Mot de passe trop faible");
        submitButton.attr("disabled", "disabled");
    }
}

// }}}


/***************************************************************************
 * The real OnLoad
 */

$(window).load(auto_links);

// vim:set et sw=4 sts=4 sws=4 foldmethod=marker enc=utf-8:
