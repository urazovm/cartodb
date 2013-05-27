# encoding: utf-8

module CartoDB
  module Visualization
    class Presenter
      def initialize(visualization)
        @visualization = visualization
      end #initialize

      def to_poro
        {
          id:               visualization.id,
          name:             visualization.name,
          map_id:           visualization.map_id,
          active_layer_id:  visualization.active_layer_id,
          type:             visualization.type,
          tags:             visualization.tags,
          description:      visualization.description,
          privacy:          visualization.privacy.upcase,
          table:            table_data_for(visualization.table),
          related_tables:   without_associated_table(visualization.related_tables),
          stats:            visualization.stats
        }
      end #to_poro

      private

      attr_reader :visualization

      def table_data_for(table=nil)
        return {} unless table
        {
          id:               table.id,
          name:             table.name,
          privacy:          table.privacy_text,
          size:             table.table_size,
          row_count:        table.rows_estimated,
          updated_at:       table.updated_at
        }
      end #table_data_for

      def without_associated_table(tables)
        return tables unless visualization.table
        tables.delete_if { |table|
          table.id == visualization.table.id
        }.map { |table| table_data_for(table) }
      end #without_associated_table
    end # Presenter
  end # Visualization
end # CartoDB

