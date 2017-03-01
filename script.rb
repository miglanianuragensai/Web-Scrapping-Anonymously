profile = Selenium::WebDriver::Firefox::Profile.new
profile['network.proxy.socks'] = "127.0.0.1"
profile['network.proxy.socks_port'] = 9050
profile['network.proxy.type'] = 1
browser = Watir::Browser.new :firefox, :profile => profile
browser.goto "whatsmyip.org"
contentsArray = File.readlines('Cricket.txt')
abc = []
for contentsArrays in contentsArray do
   abc << contentsArrays.delete!("\n")
end


images = abc.map do |person|
   browser.goto("images.google.com")
   browser.text_field(title: "Search").set person
   browser.button(type: "submit").click
   sleep 2
   doc = Nokogiri::HTML.parse(browser.html)
   doc.at_css("div#ires img")["src"]
end

subimages = []

for pupu in images do
  subimages << pupu[23..-1]
end
j = 0
for pages in subimages do
  File.open("#{abc[j]}.jpg",'wb') do |f|
  f.write(Base64.decode64(pages))
  end
j = j +1
end
