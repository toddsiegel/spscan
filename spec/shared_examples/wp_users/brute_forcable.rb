# encoding: UTF-8

shared_examples 'WpUsers::BruteForcable' do

  describe '#brute_force' do
    let(:range)           { (1..10) }
    let(:wordlist)        { 'somefile.txt'}
    let(:passwords)       { %w{password 123456 0000} }
    let(:brute_force_opt) { {} }

    it 'calls #brute_force on each wp_user' do
      range.each do |id|
        wp_user = WpUser.new(uri, id: id)
        wp_user.should_receive(:brute_force).with(passwords, brute_force_opt)

        wp_users << wp_user
      end

      WpUser::BruteForcable.stub(:passwords_from_wordlist).with(wordlist).and_return(passwords)

      wp_users.brute_force(wordlist, brute_force_opt)
    end
  end

end
