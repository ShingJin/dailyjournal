xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Entries"
    xml.description "Lots of entries"
    
    for e in @entries
      xml.item do
        xml.title e.entry_text
        xml.pubDate e.created_at.to_s(:rfc822)
      end
    end
  end
end