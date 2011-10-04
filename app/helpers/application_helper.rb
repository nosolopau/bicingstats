# -*- encoding : utf-8 -*-
module ApplicationHelper
  FEMININE_CLASSES = [Company, JobCategory]

  def table_id(id = 0)
    "#{controller.controller_name}_#{controller.action_name}_#{id}"
  end

  def menu_item(controller_name, options = {})
    %{<li class="rounded_small #{"active" if controller_name == controller.controller_name}">#{link_to(t('controllers.' + controller_name), (options.has_key?(:admin))? "admin_#{controller_name}".to_sym: controller_name.to_sym)}</li>}.html_safe
  end

  def blank
    t('common.blank')
  end

  def menu(menu)
    r = ''
    menu.each do |item|
      it = menu_item item
      r += it if it
    end
    r
  end

  def access_denied
    %{<p>#{t('common.access denied')}</p>}.html_safe
  end

  def acronym_tag(name)
    %{<acronym title="#{name}">#{truncate(name, :length => 6)}</acronym>}.html_safe
  end

  def namespace_render(partial)
    n = namespace
    render "shared#{"/#{n}" if n}/#{partial}"
  end

  def generate_url(base)
    params[:id]? "#{base}_#{controller.controller_name.singularize.downcase}".to_sym: "#{base}_new_#{controller.controller_name.singularize.downcase}".to_sym
  end

  def t_for(model, s)
    (FEMININE_CLASSES.include?(model))? tf(s, :what => t("activerecord.models.#{model.to_s.underscore}")): t(s, :what => t("activerecord.models.#{model.to_s.downcase}"))
  end

  def tf(s, options)
    t("feminine.#{s}", options)
  end

  def tf2(s, model = model_name,  options  = {})
    t("#{'feminine.' if FEMININE_CLASSES.include?(model)}#{s}", options)
  end

  def t_notice(type, model = model_name)
    tf2("common.notices.#{type}", class_name(model), :what => t_m(model)).capitalize
  end

  def namespace(c = controller)
    c.class.name[/^(\w*)::\w*$/, 1].try(:downcase)
  end

#  def controller_path(c = controller.controller_name)
#    "#{c}".to_sym
#  end

  def box_submit_or_cancel
    ("#{submit_tag(t('common.update'))}&nbsp;&nbsp;#{t('common.or').downcase} #{link_to_function(t('common.cancel').downcase, 'parent.$.fancybox.close();')}").html_safe
  end

  def t_a(attribute)
    I18n.t("activerecord.attributes.#{controller.controller_name.singularize}.#{attribute}", :default => t("attributes.#{attribute}"))
  end

  def show_client(client)
    %{<span class="inline_actions client">#{client.name}</span>}.html_safe
  end

  def show_attribute(attribute, options = {})
    m = model_name
    value = eval("@#{m}.#{attribute}")
    unless value.blank?
      "<p>
        #{"<b>#{t_a attribute}:</b>" unless options[:hide_tag]}
        #{(options[:value])? options[:value]: value }
      </p>".html_safe
    end
  end

  def t_c(c = controller.controller_name)
    I18n.t("controllers.#{c}")
  end

  def t_m(c = controller.controller_name)
    I18n.t("activerecord.models.#{c.singularize}")
  end

  def window_selector_links
    ''
  end

  def model_name(c = controller.controller_name)
    c.singularize
  end

  def class_name(c = controller.controller_name)
    c.classify.constantize
  end

  def table_links(item)
    "#{namespace_link_to(t('common.show'), item)} #{edit_link(item)} #{namespace_link_to(t('common.destroy'), item, :confirm => t('common.destroy_confirmation'), :method => :delete)}".html_safe
  end

  def admin_namespace?
    namespace == 'admin'
  end

  def show_link_to(title, path)
    namespace_link_to(title, path)
  end

  def namespace_link_to(title, path, options = {})
    "#{link_to(title, admin_namespace? ? [:admin, path]: path, options)}".html_safe
  end

  def new_link_to(title, path, options = {}, c = class_name)
    "#{link_to(title, path, options)}".html_safe
  end

  def t_new_link_to(c = controller.controller_name, params = {})
    new_path = "new_#{namespace}_#{model_name(c)}_path(#{params})"
    
    "#{link_to(t_for(class_name(c), 'common.new'), eval(new_path))}".html_safe
  end

  # Returns an image link to a function
  def image_link_to_function(action, path, options = nil)
    link_to_function(image_tag(action + '.png'), path, options)
  end

  def box_mode
    {:mode => 'box'}
  end

  def window_close_link
    link_to_function(t('common.close window'), 'parent.$.fancybox.close();')
  end

  def edit_links(item)
    %{<span class="button_links">#{namespace_link_to(t('common.show'), item)} #{back_link}</span>}.html_safe
  end

  def back_link(path  = :back)
    %{<span class="button_links">#{link_to(t('common.back'), path)}</span>}.html_safe
  end

  def show_links(item)
    %{<span class="button_links">#{edit_link(item)} #{back_link} #{link_to t('common.show'), item}</span>}.html_safe
  end

  def index_links
    %{<span class="button_links">#{t_new_link_to}</span>}.html_safe
  end

  def edit_link(item)
    link_to(t('common.edit'), eval("edit_#{"admin_" if admin_namespace?}#{model_name}_path(item)"))
  end

  def my_auto_link(text)
    auto_link(text).html_safe
  end
end
