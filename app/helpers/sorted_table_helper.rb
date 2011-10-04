# -*- encoding : utf-8 -*-
# Sorted tables helper
module SortedTableHelper
  # Returns the sorted table header
  def sorted_table_header (count, sort_classes = nil)
    options = ''
    if(sort_classes)
      sort_classes.each do |i|
        options += %{,#{i}:{sorter:'classes'}}
      end
    end
    %{
    <script type="text/javascript">
      $(document).ready(function(){
        $.tablesorter.addParser({
            // set a unique id
            id: 'classes',
            is: function(s) {
                // return false so this parser is not auto detected
                return false;
            },
            format: function(s) {
                // format your data for normalization
                return s.toLowerCase().replace(/very high/,5).replace(/high/,4).replace(/normal/,3).replace(/very low/,1).replace(/low/,2).replace(/none/,0);
            },
            // set type, either numeric or text
            type: 'numeric'
        });
        $("#sorted_table").tablesorter({
            headers:{0:{sorter:false}#{options},#{count-1}:{sorter:false}},
            sortList: [[1,0]]
          })
          .tablesorterPager({container: $("#pager")});
      });
    </script>
    }.html_safe
  end

  # Returns the table pager
  def sorted_table_pager(count)
    r = %{
    <div id="pager" class="tablesorter_pager">
        #{image_tag 'tables/first.png', :class => 'first table_button rounded_small', :title => t('common.tables.first')}
        #{image_tag 'tables/prev.png', :class => 'prev table_button rounded_small', :title => t('common.tables.previous')}
        #{text_field_tag 'page', nil, :class => 'pagedisplay exclude_select', :size => 3}
        #{image_tag 'tables/next.png', :class => 'next table_button rounded_small', :title => t('common.tables.next')}
        #{image_tag 'tables/last.png', :class => 'last table_button rounded_small', :title => t('common.tables.last')}
        <select class="pagesize">
          <option selected="selected" value="10">10</option>}
    20.step(count + 9, 10) { |i|
      r += %{<option value="#{i}">#{i}</option>}
      }
    r += %{
        </select>
    </div>
    }
    r.html_safe
  end

  # Returns the table selector
  def table_selector
    %{<div class="table_selector">#{t('common.tables.select')}:
      <a href="#" onclick="change_multiple_selection(true);">#{t('common.tables.all')}</a>
      <a href="#" onclick="change_multiple_selection(false);">#{t('common.tables.none')}</a>
      <a href="#" onclick="multiple_selection_from();">#{t('common.tables.from_selected')}</a>
      <a href="#" onclick="multiple_selection_to();">#{t('common.tables.to_selected')}</a></div>}
  end
end
