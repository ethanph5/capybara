shared_examples_for "fill_in" do
  describe "#fill_in" do
    before do
      @session.visit('/form')
    end

    it "should fill in a text field by id" do
      @session.fill_in('form_first_name', :with => 'Harry')
      @session.click_button('awesome')
      extract_results(@session)['first_name'].should == 'Harry'
    end

    it "should fill in a text field by name" do
      @session.fill_in('form[last_name]', :with => 'Green')
      @session.click_button('awesome')
      extract_results(@session)['last_name'].should == 'Green'
    end

    it "should fill in a text field by label without for" do
      @session.fill_in('First Name', :with => 'Harry')
      @session.click_button('awesome')
      extract_results(@session)['first_name'].should == 'Harry'
    end

    it "should fill in a url field by label without for" do
      @session.fill_in('Html5 Url', :with => 'http://www.avenueq.com')
      @session.click_button('html5_submit')
      extract_results(@session)['html5_url'].should == 'http://www.avenueq.com'
    end

    it "should fill in a textarea by id" do
      @session.fill_in('form_description', :with => 'Texty text')
      @session.click_button('awesome')
      extract_results(@session)['description'].should == 'Texty text'
    end

    it "should fill in a textarea by label" do
      @session.fill_in('Description', :with => 'Texty text')
      @session.click_button('awesome')
      extract_results(@session)['description'].should == 'Texty text'
    end

    it "should fill in a textarea by name" do
      @session.fill_in('form[description]', :with => 'Texty text')
      @session.click_button('awesome')
      extract_results(@session)['description'].should == 'Texty text'
    end

    it "should fill in a password field by id" do
      @session.fill_in('form_password', :with => 'supasikrit')
      @session.click_button('awesome')
      extract_results(@session)['password'].should == 'supasikrit'
    end

    it "should fill in a field with a custom type" do
      @session.fill_in('Schmooo', :with => 'Schmooo is the game')
      @session.click_button('awesome')
      extract_results(@session)['schmooo'].should == 'Schmooo is the game'
    end

    it "should fill in a field without a type" do
      @session.fill_in('Phone', :with => '+1 555 7022')
      @session.click_button('awesome')
      extract_results(@session)['phone'].should == '+1 555 7022'
    end

    it "should fill in a text field respecting its maxlength attribute" do
      @session.fill_in('Zipcode', :with => '52071350')
      @session.click_button('awesome')
      extract_results(@session)['zipcode'].should == '52071'
    end

    it "should fill in a password field by name" do
      @session.fill_in('form[password]', :with => 'supasikrit')
      @session.click_button('awesome')
      extract_results(@session)['password'].should == 'supasikrit'
    end

    it "should fill in a password field by label" do
      @session.fill_in('Password', :with => 'supasikrit')
      @session.click_button('awesome')
      extract_results(@session)['password'].should == 'supasikrit'
    end

    it "should fill in a password field by name" do
      @session.fill_in('form[password]', :with => 'supasikrit')
      @session.click_button('awesome')
      extract_results(@session)['password'].should == 'supasikrit'
    end

    it "should throw an exception if a hash containing 'with' is not provided" do
      lambda{@session.fill_in 'Name', 'ignu'}.should raise_error
    end

    context "with ignore_hidden_fields" do
      before { Capybara.ignore_hidden_elements = true }
      after  { Capybara.ignore_hidden_elements = false }
      it "should not find a hidden field" do
        msg = "no text field, text area or password field with id, name, or label 'Super Secret' found"
        running do
          @session.fill_in('Super Secret', :with => '777')
        end.should raise_error(Capybara::ElementNotFound, msg)
      end
    end

    context "with a locator that doesn't exist" do
      it "should raise an error" do
        msg = "no text field, text area or password field with id, name, or label 'does not exist' found"
        running do
          @session.fill_in('does not exist', :with => 'Blah blah')
        end.should raise_error(Capybara::ElementNotFound, msg)
      end
    end
  end
end
