require 'spec_helper'

module HerokuConfigVars
  describe ApplicationHelper do

    describe '#menu_link' do
      it 'works' do
        expect(helper.menu_link 'name', '/path').to eq(
          '<a href="/path"><span class="menu-option">name</span></a>'
        )
      end
    end

  end  
end
