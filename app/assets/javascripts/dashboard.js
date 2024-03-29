// dasboard js only

$(function(){

  // dropdown filter
	// var filter_table = function(event){
 //    $.ajax({
 //      url: '/dashboard/dropdown_values',
 //      type: 'GET',
 //      data:  { 'list':$(this).val() },
 //      cache: false,
 //      success: function(resp){
 //        $('#dropdowns').replaceWith(resp);
 //      }
 //    });
	// };
	// $('#list_filter').change(filter_table);

  //prepare fields
  // function process($fields, mode) {
  //   if ($fields.parent('.nested_attributes').hasClass('printers')) {
  //     mode = mode || $fields.find('.mode_select').val();
  //     if ($.inArray(mode, ['contract', 'warranty', 'permit', 'act']) != -1) {
  //       $fields.find('.country_label').hide();
  //       $fields.find('.country_select').hide();
  //     } else {
  //       $fields.find('.country_label').show();
  //       $fields.find('.country_select').show();
  //     }
  //   }
  // }

	// add nested fields
  // function new_nested_fields(el, id) {
  //   var $fields = $(el).closest('.nested_attributes').find('.fields.new_record').clone(true);
  //   $fields.removeClass('new_record').css('display', 'block');

  //   if (!id) {
  //     id = parseInt($fields.find('input:first').attr('id').replace(/_attributes_/, ''));
  //     id += 1;
  //   }

  //   $fields.find('*').each(function (i) {
  //     if (!$(this).is('option')) {
  //       $(this).val('');
  //     }
  //     if ($(this).attr('id') != undefined) {
  //       $(this).attr('id', $(this).attr('id').replace(/_attributes_(\d+)/, '_attributes_' + id));
  //     }
  //     if ($(this).attr('name') != undefined) {
  //       $(this).attr('name', $(this).attr('name').replace(/_attributes\]\[(\d+)/, '_attributes][' + id));
  //     }
  //     if ($(this).attr('for') != undefined) {
  //       $(this).attr('for', $(this).attr('for').replace(/_attributes_(\d+)/, '_attributes_' + id));
  //     }
  //   });
  //   return $fields;
  // }

 //  $('.nested_attributes a.add').live('click', function(e) {
	// 	e.preventDefault();
 //    var $fields = new_nested_fields(this);
 //    $(this).before($fields);
 //    process($fields);
	// });

 //  function remove_nested_fields(el, only_remove) {
 //    if (!only_remove) {
 //      $(el).prev('input[type=hidden]').val('1');
 //      $(el).closest('.fields').hide();
 //    } else
 //      $(el).closest('.fields').remove();
 //  }

	// // delete nested fields
 //  $('.nested_attributes a.remove').live('click', function(e) {
	// 	e.preventDefault();
 //    remove_nested_fields(this);
	// });

  // add new file field for printer changing
  // $('.printers .edit').live('click', function(e) {
  //   e.preventDefault();
  //   var $fields, $parent = $(this).closest('.fields');
  //   var parent_id = $parent.attr('id');

  //   $fields = $parent.next('#' + parent_id + '_edit');
  //   if (!$fields.length) {
  //     $fields = new_nested_fields(this, parent_id.replace(/\D+/, ''));
  //     $fields.attr('id', parent_id + '_edit');
  //     $fields.find('.mode_select').val($parent.data('mode'));
  //     $fields.find('a.remove').die('click').click(function(e) {
  //       e.preventDefault();
  //       remove_nested_fields(this, true);
  //     });
  //     var $country = $parent.find('.country');
  //     if ($country.length)
  //       $fields.find('.country_select').val($country.attr('id').replace(/\D+/, ''));
  //   }

  //   $parent.after($fields);
  //   process($fields);
  // });

  // show-hide country when mode changed
 //  $('.printers .mode_select').live('change', function(e) {
 //    process($(this).closest('.fields'));
	// });

  // select regions
	function loadRegions(country_id){
    $.ajax({
      url: '/dashboard/get_regions/' + country_id,
      success: function() {
        // reset regions select customization
        customizeSelect('#region_select, #city_select');
      }
    });
  }

  $('#cities_block').on('change', '#country_select', function(e){
    loadRegions($('#country_select').val());
  });

  // select cities
  function loadCities(region_id){
    $.ajax({
      url: '/dashboard/get_cities/' + region_id,
      success: function() {
        // reset cities select customization
        customizeSelect('#city_select');
      }
    });
  }

  $('#cities_block').on('change', '#region_select', function(e){
    loadCities($('#region_select').val());
  });

  // add selected city
  $('#cities_block').on('click', '.add', function(e) {
		e.preventDefault();

    var city_id = $('#city_select').val();
    if ($('#city_' + city_id).length === 0) {
      var city = {
        id: city_id,
        name: $('#city_select option:selected').text()
      };
      var tmpl = JST['companies/city'].render(city);
      $('#add_city_block').before(tmpl);
    } else {
      var $t = $(this);
      $t.tooltip('show');
      setTimeout(function() { $t.tooltip('hide') }, 3000);
    }
	});

  // tooltip for add city button
  $('#cities_block .add').tooltip({
    placement: 'top',
    trigger: 'manual',
    title: function() {
      return $(this).data('fail-message');
    }
  });

  // delete selected city
  $('#cities_block').on('click', '.del', function(e) {
		e.preventDefault();

    var id = $(this).attr('id').replace(/del_/, '');
    $('#city_'+id).remove();
	});

  // add office
  $('#offices_block').on('click', '.add', function(e) {
    e.preventDefault();

    var $f = $('#offices_block .fields'),
        $labels = $f.eq(0).find('label');
    var office = {
      id: $f.length,
      name: { label: $labels.eq(0).text(), value: '' },
      default_password: { label: $labels.eq(1).text(), value: '' }
    }
    var tmpl = JST['companies/office'].render(office);
    $('#add_office_block').before(tmpl);
  });

  // delete office
  $('#offices_block').on('click', '.del', function(e) {
    e.preventDefault();
    var $f = $(this).closest('.fields');
    $f.find(':hidden[name*=_destroy]').val('1');
    $f.hide();
  });

  // show and hide with delay tooltip on element
  function toggle_tooltip($el) {
    $el.tooltip('show');
    setTimeout(function() { $el.tooltip('hide') }, 3000);
  }

  function check_export() {
    var export_timer,
        $ei = $('#export-indicator');

    export_timer = setTimeout(function() {
      $.ajax({
        url: $ei.data('check_url'),
        dataType: 'json'
      })
      .fail(function() { check_export(); })
      .done(function(res) {
        if (res && res.working) {
          check_export();
        } else {
          $ei.removeClass('active');
          window.location = $ei.data('check_url');
        }
      });
    }, 10000);
  }

  if ($('#export-indicator').hasClass('active')) {
    check_export();
  }

});
