$(function() {
  // this is derivative of Tim Reilly's work at
  // http://github.com/timriley/complex-form-examples/commit/d00c7c0666621bdb07ff9701ce7eecabd84df4de
  // git clone git://github.com/timriley/complex-form-examples.git
  $('form a.add_template').live('click', function() {
    // Setup
    // Name of model underscored, Model.name.underscore
    var assoc   = $(this).attr('data-model');           
    var content = $('#' + assoc + '_template').html(); // Fields template
    // var dom_target = $(this).attr('data-target');
    
    var dom_target = $(this).parent().siblings('.children_fields');
    // context will be something like this for a brand new form:
    // project[tasks_attributes][1255929127459][assignments_attributes][1255929128105]
    // or for an edit form:
    // project[tasks_attributes][0][assignments_attributes][1]
    var name_context = $(dom_target).attr('data-context');
    
    // Make the context correct by replacing new_<parents> with the generated ID
    // of each of the parent objects
    
    // Make a unique ID for the new child 
    var regexp  = new RegExp(assoc + '\\[new_' + assoc + '\\]', 'g');
    var new_id  = new Date().getTime();
    var new_name = name_context + '[' + assoc + 's_attributes][' + new_id + ']';
    // replaces the top-level names
    content     = content.replace(regexp, new_name);
    // replaces name for any nested templates
    content     = content.replace( new RegExp(assoc + '\\[','g'), new_name + '[');
    
    // Now replace id strings
    var id_string = new_name.replace( /\]\[|\[|\]/g, '_').replace( /s_attributes/, '').replace(/_$/, '');
    content = content.replace(new RegExp(assoc +'_new_' + assoc, 'g'), id_string).
                      replace(new RegExp('new_' + assoc, 'g'), id_string);
    
    // fix the enclosed data context
    content = content.replace(new RegExp("data-context\=." + assoc + ".", 'g'), 'data-context="'+ new_name + '"');
    
    $(dom_target).append(content);
    return false;
  });
  
  $('form a.remove_template').live('click', function() {
    // guard against unintended deletion
    if( ! confirm("Are you sure you want to delete this?") ) { return false; }
    
    var hidden_field = $(this).prev('input[type=hidden]')[0];
    if(hidden_field) {
      hidden_field.value = '1';
    }
    $(this).parent('.' + $(this).attr('data-model')).hide();
    return false;
  });
});
