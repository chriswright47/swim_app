require 'spec_helper'

describe Team do
  let(:name) { 'Lincoln' }
  let(:mascot) { 'Cardinals' }
  before do
    @team = FactoryGirl.create(:team, name: name, mascot: mascot)
    @athlete = FactoryGirl.create(:user, team: @team)
    @coach = FactoryGirl.create(:user, coach: true, team: @team)
  end

  it 'should have a valid factory' do
    expect(@team).to be_valid
  end

  it 'should have a name' do
    expect(@team.name).to eq name
  end

  it 'should have a mascot' do
    expect(@team.mascot).to eq mascot
  end

  it 'should have a collection of athletes' do
    expect(@athlete.team).to eq @team
    expect(@team.athletes).to_not include(@coach)
    expect(@team.athletes).to include(@athlete)
  end

  it 'should have a collection of coaches' do
    expect(@coach.team).to eq @team
    expect(@team.coaches).to_not include(@athlete)
    expect(@team.coaches).to include(@coach)
  end

end
