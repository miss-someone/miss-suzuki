ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    columns do
      column do
        panel "最近の応募者" do
          ul do
            ContestantProfile.order("created_at").limit(5).reverse.map do |profile|
              li link_to(profile.name, admin_contestant_profile_path(profile))
              div profile.created_at.in_time_zone('Tokyo')
            end
          end
        end
      end
      column do
        panel "承認ステータス" do
          ul do
            li "出場者画像承認待ち"
            div "#{ContestantImage.where(is_pending: true).count}件"
            li "インタビュー承認待ち"
            div "#{InterviewAnswer.where(is_pending: true).count}件"
          end
        end
      end
    end
  end # content
end
