module RocketCMS
  module Menu
    class << self
      def get_menus
        Rails.cache.fetch 'menus', expires_in: 10.minutes do
          if RocketCMS.mongoid?
            ::Menu.all.map { |m| {id: m.id.to_s, name: m.name } }
          else
            ::Menu.all.map { |m| {id: m.id, name: m.name } }
          end
        end
      end

      def btn_js
        <<-END.strip_heredoc.gsub("\n", ' ').gsub(/ +/, ' ')
          var $t = $(this);
          $.ajax({
            type: "POST",
            url: $t.attr("href"),
            data: {ajax: true},
            success: function(r) {
              $t.attr("href", r.href);
              $t.removeClass("btn-success btn-danger");
              $t.addClass(r.class);
            },
            error: function(e) {
              alert(e.responseText);
            }
          });
          return false;
        END
      end

      def build_toggles(view, model, obj, btn_size, btn_style = '')
        ret = []
        get_menus.each do |m|
          if RocketCMS.mongoid?
            on = obj.menu_ids.include?(BSON::ObjectId.from_string(m[:id]))
          else
            on = obj.menu_ids.include?(m[:id].to_i)
          end
          ret << view.link_to(
            m[:name],
            view.toggle_menu_path(model_name: model, id: obj.id, menu: m[:id], on: !on),
            #method: :post,
            title: m[:name],
            class: "btn btn-#{btn_size} #{on ? "btn-success" : "btn-danger"}",
            style: btn_style,
            onclick: btn_js
          )
        end
        ret
      end
    end
  end
end
