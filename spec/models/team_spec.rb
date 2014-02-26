require 'spec_helper'

describe Team do
  before do
    @team = FactoryGirl.create(:team)
    @athlete = FactoryGirl.create(:user, team: @team)
    @coach = FactoryGirl.create(:user, coach: true, team: @team)
  end

  it 'should have a valid factory' do
    expect(@team).to be_valid
  end

  it 'should have the right name' do
    expect(@team.name).to eq 'Lincoln'
  end

  it 'should have the right mascot' do
    expect(@team.mascot).to eq 'Cardinals'
  end

  it 'should have a collection of athletes' do
    expect(@athlete.team).to eq @team
    expect(@team.athletes).to include(@athlete)
  end

  it 'should have a collection of coaches' do
    expect(@coach.team).to eq @team
    expect(@team.coaches).to include(@coach)
  end

end
