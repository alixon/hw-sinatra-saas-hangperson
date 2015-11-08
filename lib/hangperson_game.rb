class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  @@MAX_WRONG_GUESSES = 7
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  attr_accessor :word, :guesses, :wrong_guesses

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
  
    raise ArgumentError if letter.nil? or letter.empty? or not  letter.match(/[a-z]/i)
  
    letter.downcase!
    unless self.guesses.include? letter or self.wrong_guesses.include? letter
      self.word.include?(letter) ? self.guesses += letter : self.wrong_guesses += letter
    else
      false
    end
    
 end
 
 def word_with_guesses
    result = self.word.chars
    result.map! { |char| self.guesses.include?(char) ? char : '-' }
    result.join('')
 end
  

  def check_win_or_lose
    result = :play
    if self.wrong_guesses.length >= @@MAX_WRONG_GUESSES
      result = :lose  
    elsif not self.guesses.empty?
      regexp = Regexp.new("[#{self.guesses}]")
      result = :win if self.word.gsub(regexp, '').empty?
    end
    result
      
   end
  
  

end
