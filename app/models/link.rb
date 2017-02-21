class Link < ActiveRecord::Base
  acts_as_votable

  has_attached_file :image, styles: { medium: "720x480>", small: [ "720x480>", :jpeg ] }
  validates_attachment :image, content_type: { content_type: ["image/gif"] }

  validates :title, :presence => true
  validates :content, :presence => true,
                      :length => { :minimum => 3 }

  belongs_to :user
  belongs_to :categorys
  has_many :comments, :dependent => :destroy
  has_many :taggings, :dependent => :destroy
  has_many :tags, through: :taggings, :dependent => :destroy

  def self.tagged_with(name)
    Tag.find_by_name!(name).links
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(" ")
  end

  def tag_list=(names)
    self.tags = names.split(" ").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def self.search(search)
    where("title LIKE ?", "%#{search}%")
  end
end
