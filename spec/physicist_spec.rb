require 'spec_helper'
require 'physicist'

describe Physicist do
  it "should have a VERSION constant" do
    expect(subject.const_get('VERSION')).to_not be_empty
  end
end

describe Body do
  subject(:body) do
    Body.new(
      position: position,
      velocity: velocity,
      dimensions: dimensions,
      t0: t0
    )
  end

  let(:x0) { body.position[0] }
  let(:y0) { body.position[1] }
  let(:vx0) { body.velocity[0] }
  let(:vy0) { body.velocity[1] }
  let(:width)  { body.dimensions[0] }
  let(:height) { body.dimensions[1] }

  let(:gravity) { body.gravity }

  context 'attributes' do
    let(:position)     { 'the_position' }
    let(:velocity)     { 'the_velocity' }
    let(:dimensions)   { 'the_dimensions' }
    let(:t0)           { 'the_time' }

    it 'should have dimensions' do
      expect(body.dimensions).to eq('the_dimensions')
    end

    it 'should have a position' do
      expect(body.position).to eq('the_position')
    end

    it 'should have a velocity' do
      expect(body.velocity).to eq('the_velocity')
    end

    it 'should have a start time' do
      expect(body.t0).to eq('the_time')
    end
  end

  context 'instance methods' do
    let(:position)   { [0,10] }
    let(:velocity)   { [0,0]  }
    let(:dimensions) { [2,2]  }

    let(:t0) { Time.local(1990) }

    describe "#at" do
      # step forward one second (time unit for velocities)
      let(:t) { t0 + 1 }

      it 'should return a body with updated t0 = t' do
        expect(body.at(t).t0).to eq(t)
      end

      it 'should increment position by velocity' do
        x,y = *body.at(t).position

        aggregate_failures "increments both axes" do
          expect(x).to eq(vx0+x0)
          expect(y).to eq(vy0+y0+gravity)
        end
      end

      it 'should apply gravity' do
        _,vy  = *body.at(t).velocity

        expect(vy).to eq(vy0+gravity)
      end

      describe 'not pushing bodies through impediments' do
        let(:body_at_t) do
          body.at(t, obstacles: obstacles)
        end


        context "with an obstacle directly beneath the body" do
          let(:obstacles) do
            [
              SimpleBody.new(position: [ x0, y0 + height ], dimensions: [ width, height ])
            ]
          end

          it 'should stop vertical movement entirely' do
            _,vy = *body_at_t.velocity
            _,y = *body_at_t.position
            expect(vy).to eq(0)
            expect(y0).to eq(y)
          end
        end

        context "with an obstacle 9.8 units beneath the body" do
          let(:obstacles) do
            [
              SimpleBody.new(
                position: [x0, y0 + height + 9.8],
                dimensions: [width,height]
              )
            ]
          end

          it 'should stop vertical movement after 1s' do
            _,vy = *body_at_t.velocity
            _,y = *body_at_t.position
            expect(y0 + 9.8).to eq(y)
            expect(vy).to eq(0)
          end
        end

        context "with no obstacles" do
          let(:obstacles) { [] }

          it 'should be in freefall' do
            _,vy = *body_at_t.velocity
            _,y = *body_at_t.position
            expect(y0 + 9.8).to eq(y)
            expect(vy).to eq(9.8)
          end
        end
      end
    end
  end
end
