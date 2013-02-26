
$(function(){

  // Make deleting nice
  $('td.delete').each(function(){
    var $td = $(this);
    var $tr = $td.parents('tr');
    var $box = $td.find('[type="checkbox"]');
    //$box.hide()
    $box.change(function(){
      $box.get(0).checked ? $tr.addClass('deleted') : $tr.removeClass('deleted');
    });
  });

  // Dynamically add new text fields as they're used
  $('tr.new input.new_key').blur(function(){
    var $input  = $(this)
    var input   = this;
    var $tr     = $input.parents('tr');

    if ( $input.val() == '' || $tr.next().length > 0 ) return;

    $tr.clone(true).insertAfter($tr).find('input').each(function(){
      $(this).val('');
    });
  });

});
