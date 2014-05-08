class ComparisonController < ApplicationController

	def show_comparison

		e1 = params[:e1].to_s
		e2 = params[:e2].to_s

		
		#Figure out what type of entity the investor is
		@e1_investable = Investable.find_by(name: e1)

		if(@e1_investable == nil)
			flash[:danger] = "Error: Entity 1 doesn't exist"
			return redirect_to controller: :comparison, action: :new
		end

		@e1Type = @e1_investable.e_type

		if(@e1Type == 1) #Individual
			flash[:warning] = "Sorry, this system doesn't support comparisons with individuals"
			return redirect_to controller: :comparison, action: :new

		elsif(@e1Type == 2) #Portfolio

			@entity1 = Portfolio.find_by(name: e1)
			@entity1_quotes = @entity1.portfolio_snapshots

		elsif(@e1Type == 0) #Company

			@entity1 = Company.find_by(name: e1)
			@entity1_quotes = @entity1.quotes.where("offset = 0").order(date: :asc)

		else
			return flash[:danger] = "Error showing comparison. Please try again or contact an administrator"
		end


		#Figure out what type of entity the investor is
		@e2_investable = Investable.find_by(name: e2)

		if(@e2_investable == nil)
			flash[:danger] = "Error: Entity 2 doesn't exist"
			return redirect_to controller: :comparison, action: :new
		end

		@e2Type = @e2_investable.e_type

		if(@e2Type == 1) #Individual
			flash[:warning] = "Sorry, this system doesn't support comparisons with individuals"
			return redirect_to controller: :comparison, action: :new

		elsif(@e2Type == 2) #Portfolio

			@entity2 = Portfolio.find_by(name: e2)
			@entity2_quotes = @entity2.portfolio_snapshots

		elsif(@e2Type == 0) #Company

			@entity2 = Company.find_by(name: e2)
			@entity2_quotes = @entity2.quotes.where("offset = 0").order(date: :asc)

		else
			return flash[:danger] = "Error showing comparison. Please try again or contact an administrator"
		end

	end

end
