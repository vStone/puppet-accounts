require 'spec_helper'


describe 'accounts::hiera' do

  let (:title) {'foobar'}

  describe 'with defaults' do
    let (:params) {{
      'uid' => 1000
    }}

    it do
      is_expected.to contain_user('foobar').with_uid(1000).with_ensure('present')
    end
  end

  describe 'with extra_params' do
    let (:params) {{
      'uid' => 1000,
      'extra_params' => {
        'comment' => 'foobar for prez'
      }
    }}

    it do
      is_expected.to contain_user('foobar').with_uid(1000).with_ensure('present').with_comment("foobar for prez")
    end

  end

end
