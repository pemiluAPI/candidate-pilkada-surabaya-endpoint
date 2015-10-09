module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :provinces do
      desc "Return all provinces"
      get do
        {
          results: Province.apiall(params)
        }
      end
    end

    resource :regions do
      desc "Return all regions"
      get do
        {
          results: Region.apiall(params)
        }
      end
    end

    resource :candidates do
      desc "Return all candidates"
      get do
        {
          results: Candidate.apiall(params)
        }
      end
    end

    resource :vision_missions do
      desc "Return all vision_missions"
      get do
        {
          results: VisionMision.apiall(params)
        }
      end
    end
  end
end