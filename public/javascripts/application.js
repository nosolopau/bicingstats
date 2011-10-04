function init(layout){
    if(layout == 'normal'){
        $(".sorted_table").dataTable({
            "bStateSave": true,
            "sPaginationType": "full_numbers",
            "sDom": '<"table_wrapper"<"top rounded_smallest"fp<"clear">>rt<"bottom rounded_smallest"l>>',
            "oLanguage": {
                "sUrl": "/other/datatables_es"
            },
            "aoColumnDefs": [
                { "bSortable": false, "aTargets": [ -1 ] }
            ],
            "fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay ) {
                refresh();
            }
	});
        $(".lines_sorted_table").dataTable({
            "sPaginationType": "full_numbers",
            "sDom": '<"table_wrapper"<"top rounded_smallest"fp<"clear">>rt<"bottom rounded_smallest"l>>',
            "oLanguage": {
                "sUrl": "/other/datatables_es"
            },
            "aaSorting": [],
            "fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay ) {
                refresh();
            }
	});
    }

    refresh();    
    select_first_input();
    init_inline_actions();

    $('.submittable').live('change', function() {
        $(this).parents('form:first').submit();
    });

    init_fancybox();
}

function refresh(){
    init_rounded_borders();
}

function init_fancybox(){
    $('a.box').fancybox({
        'type': 'iframe',
        'autoScale' : true,
        'transitionIn': 'fade',
        'transitionOut': 'fade',
        'titleShow':false,
        'height': '75%'
    });
}

function init_inline_actions(){
    return false;
    
    $('.inline_actions').mouseover(function(){$(this).addClass('selected_inline_actions').corner("3px")});
    $('.inline_actions').mouseout(function(){$(this).removeClass('selected_inline_actions')});
}

/** Sets rounded borders */
function init_rounded_borders(){
    $("a").each(function(){$(this).corner("2px");});
    $(".rounded_smallest, input, textarea, select ,.notice, .alert, #error_explanation, .data, form, table").each(function(){$(this).corner("3px");});
    $(".rounded_small").each(function(){$(this).corner("4px");});
    $(".rounded_normal").each(function(){$(this).corner("10px");});
    $(".rounded_top").each(function(){$(this).corner("top 3px");});
    $(".rounded_bottom").each(function(){$(this).corner("bottom 3px");});
    $(".rounded_left").each(function(){$(this).corner("left 3px");});
    $(".button_links a").each(function(){$(this).corner("3px");});
    $(".tablesorter tr th, .line_table tr th").each(function(){$(this).corner("3px");});
}

/** Update the checkboxes selected in a window */
function update_selected_items(type){
    $('[type=checkbox]').attr('checked',false);
    parent.$('ul#'+type+'>li>input').each(function(){
        $("#item_"+$(this).val()).attr('checked',true);
    });
}

/** Selects first input in forms */
function select_first_input(){
    $("input[type='text']:not(.exclude_select):first", document.forms[0]).focus().select();$(".force_select:first", document.forms[0]).focus().select();
}