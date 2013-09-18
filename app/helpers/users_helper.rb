module UsersHelper

    def can_manage
        if user_signed_in?
            deny_access("You do not have permission to view this page") unless current_user.can_manage
        end
    end

    def can_sell
        if user_signed_in?
            deny_access("You do not have permission to view this page") unless current_user.can_sell
        end
    end

    def can_report
        if user_signed_in?
            deny_access("You do not have permission to view this page") unless current_user.can_report
        end
    end

    def deny_access(notice)
        redirect_to root_path, :notice => notice
    end
end
