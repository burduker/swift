#coding:utf-8
class Folder
  include DataMapper::Resource

  property :id, Serial
    
  property :title, String, :required => true

  timestamps!
  userstamps!
  sluggable!

  #relations
  belongs_to :account, :required => false
  has n, :images
  has n, :assets

end
