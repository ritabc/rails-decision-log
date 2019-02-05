# Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
#   load seed
# end

Circle.destroy_all
Decision.destroy_all

circles = Circle.create!([{name: 'General Circle', description: "Central governing body, comprised of Functional Circle Operational Leaders (OL's) and Elected Representatives (ER's)"}, {name: 'Planning, Design, and Development', description: "Tasked with county approvals, site planning and strategy, landowner negotiation, and business planning"}, {name: 'Governance and Training', description: "Tasked with sociocracy and collaborative skills oversight and training, administrative oversight, other educational/event offerings as needed"}, {name: 'Membership and Marketing', description: "Tasked with policies, process, orientation and integration regarding membership, maintaining records, membership advancement and exit, and marketing."}, {name: 'Land Stewardship', description: "Tasked with recommending and facilitating land improvements, managing gards and the farm, coordinating work days"}, {name: 'Financial & Legal', description: "Tasked with financial planning, accounting and record-keeping, reporting, entities management, and financing"}])

decisions = Decision.create!([
  {name: "Gate Lock", description: "We decided that the lock on the gate at Faye St should be a combination lock instead of a key lock. This way folks who need to access the land (for instance Daniel S. who sometimes mows), can easily do so without arranging for someone with a key to meet them or unlock it prior. Anthony can be contacted for the combination.",  date_decided: Date.new(2015,9,17), circle_id: Circle.find_by(name: "Land Stewardship").id, supp_doc_one_type: "Minutes", supp_doc_one_link: "https://hartsmill.onlyoffice.com/products/files/doceditor.aspx?fileid=4579533"},

  {name: "Childcare at Events", description: "We decided to have childcare at our social events and workdays for the next few months. Hopefully this will encourage folks with small children to get to know us better and allow us to show our commitment to inclusvity.", date_decided: Date.new(2015,9,3), circle_id: Circle.find_by(name: "Membership and Marketing").id, supp_doc_one_type: "Minutes", supp_doc_one_link: "https://hartsmill.onlyoffice.com/products/files/doceditor.aspx?fileid=4558441"},

  {name: "Membership Exit Procedures", description: "Outlines procedures for members to leave Hart's Mill under a variety of circumstances.", date_decided: Date.new(2015,7,9), circle_id: Circle.find_by(name: "Membership and Marketing").id, supp_doc_one_type: "Proposal", supp_doc_one_link: "https://hartsmill.onlyoffice.com/products/files/doceditor.aspx?fileid=4486220"},

  {name: "Upgrade toilet (officially, 'A Really Shitty Decision')", description: "We resolved to upgrade toilet facilities with some sort of moveable wooden outhouse. Anthony will work this into planning for spring.", date_decided: Date.new(2015,7,9), circle_id: Circle.find_by(name: "Land Stewardship").id, supp_doc_one_type: "Minutes", supp_doc_one_link: "https://hartsmill.onlyoffice.com/products/files/doceditor.aspx?fileid=4626376"}
  ])
