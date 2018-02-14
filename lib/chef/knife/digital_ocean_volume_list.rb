# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require 'chef/knife/digital_ocean_base'

class Chef
  class Knife
    class DigitalOceanVolumeList < Knife
      include Knife::DigitalOceanBase

      banner 'knife digital_ocean volume list (options)'

      def run
        $stdout.sync = true

        validate!

        volume_list = [
          ui.color('ID',          :bold),
          ui.color('Name',        :bold),
          ui.color('Description', :bold),
          ui.color('Size (GB)',   :bold),
          ui.color('Region',      :bold)
        ]

        volumes = client.volumes.all

        volumes.each do |volume|
          volume_list << volume.id.to_s
          volume_list << volume.name.to_s
          volume_list << volume.description.to_s
          volume_list << volume.size_gigabytes.to_s
          volume_list << volume.region.name.to_s
        end

        puts ui.list(volume_list, :uneven_columns_across, 5)
      end
    end
  end
end
