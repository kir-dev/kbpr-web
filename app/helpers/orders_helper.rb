module OrdersHelper
    def send_notification(order)
        if Rails.env.production?
            uri = URI('https://ntfy.noeyouth.eu/kbpr')
            body = "#{Group.find_by(id: order["group_id"]).name} rendelt plakátot. #{if order["printed_by_me"] == "1" then "Ők nyomtatják" else "Kbpr nyomtatja" end}"
            headers = { 'Authorization' => 'Bearer ' + Rails.application.credentials.notification_api_key,
                    'Title' => "Új rendelés",
                    'Tags' => 'inbox_tray, uj-rendeles',
                    'Priority' =>  'default',
                    'Action' => 'view, Megnyitás, https://kbpr.sch.bme.hu/orders, clear=true'}
            response = Net::HTTP.post(uri, body.to_json, headers)
            if response.code != "200"
                return
            end
        end
    end
end
