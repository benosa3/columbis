﻿var SITE = SITE || {};SITE.fileInputs = function() {  var $this = $(this),      $val = $this.val(),      valArray = $val.split('\\'),      newVal = valArray[valArray.length-1],      $button = $this.siblings('.select_file'),      $fakeFile = $this.siblings('.file_holder');  if(newVal !== '') {    //$button.text('Выберите файл');    if($fakeFile.length === 0) {    	//$button.text('');      $button.after('<span class="file_holder">Выбран файл: <strong>' + newVal + '</strong></span>');    } else {      $fakeFile.html('Выбран файл: <strong>' + newVal + '</strong>');    }  }};$(function(){	$('.file input[type=file]').bind('change focus click', SITE.fileInputs);   $(".header select").ikSelect({		autoWidth: false	});	$(".standart_select").ikSelect({		autoWidth: false,		customClass: "standart_select",		ddCustomClass: "standart_select"	});	$(".office_select").ikSelect({		autoWidth: false,		customClass: "office_select",		ddCustomClass: "office_select"	});	$(".filter select").ikSelect({		autoWidth: false,		customClass: "filter_select",		ddCustomClass: "filter_select"	});	$(".airline_select").ikSelect({		autoWidth: false,		customClass: "airline_select",		ddCustomClass: "airline_select"	});	$(".big_airline_select").ikSelect({		autoWidth: false,		customClass: "big_airline_select",		ddCustomClass: "big_airline_select"	});	$(".big_select .payment").ikSelect({		autoWidth: false,		customClass: "big_payment_select",		ddCustomClass: "big_payment_select"	});	$(".payment").ikSelect({		autoWidth: false,		customClass: "payment_select",		ddCustomClass: "payment_select"	});	$(".flight_from_select").ikSelect({		autoWidth: false,		customClass: "flight_from_select",		ddCustomClass: "flight_from_select"	});	$(".tour_operator_select").ikSelect({		autoWidth: false,		customClass: "tour_operator_select",		ddCustomClass: "tour_operator_select"	});	$(".route_select").ikSelect({		autoWidth: false,		customClass: "route_select",		ddCustomClass: "route_select"	});	$(".resort_select").ikSelect({		autoWidth: false,		customClass: "resort_select",		ddCustomClass: "resort_select"	});	$(".pagination select").ikSelect({		autoWidth: false,		customClass: "pagination_select",		ddCustomClass: "pagination_select"	});	$(".single_row select").ikSelect({		autoWidth: false,		customClass: "single_row",		ddCustomClass: "single_row"	});	$(".color_select").ikSelect({		autoWidth: false,		customClass: "color_select",		ddCustomClass: "color_select"	});	$(".importance select").ikSelect({		autoWidth: false,		customClass: "importance_select",		ddCustomClass: "importance_select"	});	$("select.list").ikSelect({		autoWidth: false,		customClass: "list_select",		ddCustomClass: "list_select"	});	$(".white select").ikSelect({		autoWidth: false,		customClass: "company_select",		ddCustomClass: "company_select"	});	$(".food_select").ikSelect({		autoWidth: false,		customClass: "food_select",		ddCustomClass: "food_select"	});	$(".medical_insurance_select").ikSelect({		autoWidth: false,		customClass: "medical_insurance_select",		ddCustomClass: "medical_insurance_select"	});	$(".placement_select").ikSelect({		autoWidth: false,		customClass: "placement_select",		ddCustomClass: "placement_select"	});	$(".nights_select").ikSelect({		autoWidth: false,		customClass: "nights_select",		ddCustomClass: "nights_select"	});	$(".crossing_select").ikSelect({		autoWidth: false,		customClass: "crossing_select",		ddCustomClass: "crossing_select"	});	$(".price_select").ikSelect({		autoWidth: false,		customClass: "price_select",		ddCustomClass: "price_select"	});	$(".first_number_visas_select").ikSelect({		autoWidth: false,		customClass: "first_number_visas_select",		ddCustomClass: "first_number_visas_select"	});	$(".last_number_visas_select").ikSelect({		autoWidth: false,		customClass: "last_number_visas_select",		ddCustomClass: "last_number_visas_select"	});	$(".number_visas_select").ikSelect({		autoWidth: false,		customClass: "number_visas_select",		ddCustomClass: "number_visas_select"	});	$(".insurance_select").ikSelect({		autoWidth: false,		customClass: "insurance_select",		ddCustomClass: "insurance_select"	});	$(".documentation_select").ikSelect({		autoWidth: false,		customClass: "documentation_select",		ddCustomClass: "documentation_select"	});	$(".reservations tr:odd,.company .grey_block .fake_row:odd").addClass("odd");	$(".reservations td p").hover(function(){		$(this).find(".hide_text").fadeToggle(500);	});	$("label.checkbox").click(function(){		$(this).toggleClass('active');	});/*** Float_panel ***/        var a = function() {            var b = $(window).scrollTop();            var not_h = parseInt($('.all').height());            var window_h = parseInt($(window).height());            var wrapper = $(".wrapper");            window_h=not_h-window_h;            //alert(window_h);            var c = $(".float_panel");            //$(".float_panel").html('b='+b+' '+window_h);            if (b >= window_h ) {                c.css({position:"fixed",bottom:"90px"})                //wrapper.css({margin: "18px 0 100px 0"})            } else {                c.css({position:"fixed",bottom:"0"})                wrapper.css({margin: "18px 0 100px 0"})            }        };        $(window).scroll(a);a()/*** Calendar ***/$(".datepicker").datepicker({	changeMonth: true,	changeYear: true,	dateFormat: 'dd.mm.yy'});$(".datepicker").click(function(){	$(".ui-datepicker-header select").ikSelect({		autoWidth: false,		customClass: "calendar_select",		ddCustomClass: "calendar_select"	});});});