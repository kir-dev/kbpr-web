module HomeHelper
    def random_text
     # pick one of them randomly
     tmp = FunkyText.find(FunkyText.pluck(:id).sample)
     return tmp.content.to_plain_text
    end
end
