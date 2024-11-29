module OrdersHelper
    def send_notification(order)
        if Rails.env.production?
            uri = URI('https://ntfy.noeyouth.eu/kbpr')
            body = "#{Group.find_by(id: order["group_id"]).name} #{if order["printed_by_me"] == "1" then "nyomtat" else "rendelt" end} plakátot."
            headers = { 'Authorization' => 'Bearer ' + Rails.application.credentials.notification_api_key,
                    'Title' => "#{if order["printed_by_me"] == "1" then "Egy kör nyomtat" else "Új rendelés" end}",
                    'Tags' => "#{if order["printed_by_me"] == "1" then "printer, uj-nyomtatas" else "inbox_tray, uj-rendeles" end}",
                    'Priority' =>  'default',
                    'Action' => 'view, Megnyitás, https://kbpr.sch.bme.hu/orders, clear=true'}
            response = Net::HTTP.post(uri, body.to_json, headers)
            if response.code != "200"
                return
            end
        end
    end
end
