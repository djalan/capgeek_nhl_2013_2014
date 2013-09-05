# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Pool::Application.config.secret_key_base = '7f214362f3a09c4c78a381b6d9288b9fa7158845d29fc094cd3b85af01e45ebdbd5de0fe469650cdc64c4daf74c26c89fd064dd9ca798fcc7bc084c2dd277fc3'
