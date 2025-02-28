# frozen_string_literal: true

require_relative 'client'
require_relative 'helpers'

class DuoApi
  ##
  # Duo Device API (https://duo.com/docs/deviceapi)
  #
  class Device < DuoApi
    def create_device_cache(mkey:, **optional_params)
      # optional_params: active
      post("/device/v1/management_systems/#{mkey}/device_cache", optional_params)[:response]
    end

    def add_device_cache_devices(mkey:, cache_key:, devices:)
      params = { devices: devices }
      post("/device/v1/management_systems/#{mkey}/device_cache/#{cache_key}/devices", params)[:response]
    end

    def get_device_cache_devices(mkey:, cache_key:, **optional_params)
      # optional_params: device_ids
      data_array_path = %i[response devices_retrieved]
      metadata_path = %i[response]
      get_all("/device/v1/management_systems/#{mkey}/device_cache/#{cache_key}/devices", optional_params,
              data_array_path: data_array_path, metadata_path: metadata_path).dig(*data_array_path)
    end

    def delete_device_cache_devices(mkey:, cache_key:, devices:)
      params = { devices: devices }
      delete("/device/v1/management_systems/#{mkey}/device_cache/#{cache_key}/devices", params)[:response]
    end

    def activate_device_cache(mkey:, cache_key:)
      post("/device/v1/management_systems/#{mkey}/device_cache/#{cache_key}/activate")[:response]
    end

    def delete_device_cache(mkey:, cache_key:)
      delete("/device/v1/management_systems/#{mkey}/device_cache/#{cache_key}")[:response]
    end

    def get_device_caches(mkey:, status:)
      params = { status: status }
      get("/device/v1/management_systems/#{mkey}/device_cache", params)[:response]
    end

    def get_device_cache(mkey:, cache_key:)
      get("/device/v1/management_systems/#{mkey}/device_cache/#{cache_key}")[:response]
    end
  end
end
