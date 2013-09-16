$(function() {
  var OfficeWithPassword = {
    use_office_selector: $('select#user_office_id'),
    use_office_label: $('#use_office_password_label'),
    use_office_checkbox: $('#user_use_office_password'),
    password_block: '#password_block',

    init: function(checken_office) {
      $('select#user_office_id').change(function() {
        OfficeWithPassword.change_select_block(this.value);
      });
      this.change_select_block(checken_office);
    },

    change_select_block: function(office_id) {
      var offices = this.use_office_label.attr('checkable_offices');

      if (offices != undefined && offices != "" && $.inArray(office_id, offices.split(',')) != -1) {
        this.bind_data_message_to_checkbox(true);
        this.enabled_checkbox_use_office(true);
        this.use_office_label.on('click', function() {
          OfficeWithPassword.change_password_block(false);
        });
      } else {
        this.bind_data_message_to_checkbox(false);
        this.enabled_checkbox_use_office(false);
      }
      this.change_password_block(true);
    },

    bind_data_message_to_checkbox: function(is_bind) {
      if (is_bind) {
        bind_to_checkbox_data_message(this.use_office_label);
      } else {
        this.use_office_label.unbind('click');
      }
    },

    change_password_block: function(is_init) {
      var condition = this.use_office_label.hasClass('active');
      if (!is_init) {
        condition = !condition;
      }
      if (condition) {
        $(this.password_block + " *").attr('disabled', true);
      } else {
        $(this.password_block + " *").removeAttr('disabled');
      };
    },

    enabled_checkbox_use_office: function(is_enabled) {
      if(is_enabled) {
        this.use_office_label.removeClass('disabled');
      } else {
        this.use_office_label.addClass('disabled');
        this.use_office_label.removeClass('active');
        this.use_office_checkbox.removeAttr('checked');
      }
    }
  }

  OfficeWithPassword.init( $('select#user_office_id option[selected="selected"]').attr('value') );
});