class ActivitiesSerializer
  include JSONAPI::Serializer

  set_id nil

  attributes :destination
  attributes :forecast do

  end
  attributes :activities do

  end
end
