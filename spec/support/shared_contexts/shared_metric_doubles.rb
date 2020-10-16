# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_context 'shared metric doubles', shared_context: :metadata do
  let(:metrics_double) do
    double(
      address: 'test/path',
      visits: 1,
      unique_visits: 1,
      visits_to_s: '1 visit',
      unique_visits_to_s: '1 unique visit'
    )
  end

  let(:metrics_double2) do
    double(
      address: 'test/path/2',
      visits: 2,
      unique_visits: 3,
      visits_to_s: '2 visits',
      unique_visits_to_s: '3 unique visits'
    )
  end

  let(:standard_filter) { %i[visits unique_visits] }
end
