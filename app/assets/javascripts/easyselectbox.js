/*
 * Easy Select Box 1.0.1
 * http://www.codefleet.com/easy-select-box
 * Replace select with custom html for easy styling via css.
 * Features: multiple instances, initial value specified by selected attribute, optional classname, optional speed
 * Tested: IE7, IE8, Chrome 10, FF3, Safari 3.2 windows, Opera 11
 * 
 * Copyright 2011, Nico Amarilla
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * License same as jQuery http://jquery.org/license
 */
(function(a){a.fn.extend({easySelectBox:function(b){var c={className:"easy-select-box",speed:0};var b=a.extend(c,b);return this.each(function(){var j=b;var k=a(this);if("select"!=k[0].nodeName.toLowerCase()){return false}var d=k.children("option");var h=null;var i=k.val();var g="easy-select-box-disp";var e=0;var f="";a.each(d,function(l,m){f+='<li><a href="#" rel="'+a(m).val()+'">'+a(m).text()+"</a></li>";if(i==a(m).val()){e=l}});f='<div class="'+j.className+'"><a class="'+g+'" href="#">'+d.eq(e).text()+"</a><ul>"+f+"</ul></div>";h=a(f).insertAfter(k);k.hide();h.data("o",j);easySelectRegistry=a(document).data("easySelect");if(easySelectRegistry==null){easySelectRegistry=new Array()}easySelectRegistry.push(h);a(document).data("easySelect",easySelectRegistry);h.click(function(l){if(a(h).children("ul").is(":visible")){a(h).children("ul").slideUp(j.speed);h.css("z-index",99)}else{easySelectRegistry=a(document).data("easySelect");if(easySelectRegistry!=null){a.each(easySelectRegistry,function(){opts=a(this).data("o");a(this).children("ul").slideUp(opts.speed);a(this).css("z-index",99)})}a(h).children("ul").slideDown(j.speed);h.css("z-index",100)}l.stopPropagation();return false});a(document).click(function(){easySelectRegistry=a(document).data("easySelect");if(easySelectRegistry!=null){a.each(easySelectRegistry,function(){if(a(this).children("ul").is(":visible")){opts=a(this).data("o");a(this).children("ul").slideUp(opts.speed)}})}});h.children("ul").children("li").click(function(){h.children("."+g).html(a(this).children("a").html());k.children("option").removeAttr("selected");k.find("option").eq(a(this).index()).attr("selected","selected");k.change();loadPreview()})})}})})(jQuery);