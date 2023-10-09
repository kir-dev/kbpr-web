module HomeHelper
    def random_text
     # pick one of them randomly
     return 'Nincs funky text, tölts fel valamit..' if FunkyText.count.zero?

     tmp = FunkyText.order("RANDOM()").first
     tmp.content.to_plain_text
    end
end
