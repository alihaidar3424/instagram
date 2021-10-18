# frozen_string_literal: true

user_ali = User.create(name: 'Ali Haidar', email: 'ali.haidar@devsinc.com', password: '123456')
user_mudassar = User.create(name: 'Mudassar Hassan', email: 'mudassar.hassan@devsinc.com', password: '123456')

user_ali_post = Post.create(content: 'This is first post by Ali', user: user_ali)
user_mudassar_post = Post.create(content: 'This is first post by Mudassar', user: user_mudassar)

user_ali_post.images.attach(
  io: File.open(Rails.root.join('app/assets/images/screenshot1.jpg')),
  filename: 'screenshot1.jpg',
  content_type: 'screenshot1/jpg'
)

user_mudassar_post.images.attach(
  io: File.open(Rails.root.join('app/assets/images/screenshot1.jpg')),
  filename: 'screenshot2.jpg',
  content_type: 'image/jpg'
)
