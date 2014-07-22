xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Rails Tutorial Title"
    xml.description "blabla description"
    xml.link microposts_url(:rss)

    for post in @microposts
      xml.item do
        xml.description post.content
        xml.pubDate post.created_at.to_s(:rfc822)
      end
    end
  end
end