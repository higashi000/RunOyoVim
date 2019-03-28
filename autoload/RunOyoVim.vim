let s:save_cpo = &cpo
set cpo&vim

function! RunOyoVim#Tweet(tweetText)
ruby << RUBY
  require 'twitter'

  @client = Twitter::REST::Client.new do |config|
    config.consumer_key = VIM.evaluate('g:consumer_key')
    config.consumer_secret = VIM.evaluate('g:consumer_secret')
    config.access_token = VIM.evaluate('g:access_token')
    config.access_token_secret = VIM.evaluate('g:access_token_secret')
  end
RUBY
endfunction

function! RunOyoVim#GetTL()
ruby << RUBY
require 'twitter'

@client = Twitter::REST::Client.new do |config|
  config.consumer_key = VIM.evaluate('g:consumer_key')
  config.consumer_secret = VIM.evaluate('g:consumer_secret')
  config.access_token = VIM.evaluate('g:access_token')
  config.access_token_secret = VIM.evaluate('g:access_token_secret')
end

@client.home_timeline.reverse_each do |tweet|
  print tweet.user.name + "\n"
  print tweet.user.screen_name + "\n"
  print tweet.text + "\n"
  print "\n" + "--------------------------" + "\n\n"
end
RUBY
redir END
endfunction

function! RunOyoVim#SeeTL()
  e ~/.TL.txt
  let outputfile = "$HOME/.TL.txt"
  execute ":redir!>".outputfile
    silent! call RunOyoVim#GetTL()
  redir END
  checktime
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
