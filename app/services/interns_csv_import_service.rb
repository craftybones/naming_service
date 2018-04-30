require 'csv'

class InternsCsvImportService

  def initialize(file)
    @filename = file.original_filename
    @rows = get_rows_hash(file)
  end

  def import
    return import_summary_on_invalid_headers(@filename, @rows.length) if invalid_headers?

    interns = @rows.map { | row |
      intern = Intern.new(row)
      intern.save
      intern
    }
    import_results(@filename, interns)
  end

  private

  def get_rows_hash file
    csv_data = CSV.read(file.path, headers: true)
    csv_data.entries.map { |r| r.to_h }
  end

  def import_summary_on_invalid_headers(filename, total_rows)
    {
        filename: filename,
        errors: ['Invalid headers'],
        total: total_rows,
        failed: total_rows,
        success: 0,
        invalid_rows: []
    }
  end

  def import_results(filename, all_rows)
    invalid_rows = select_invalid_rows_from all_rows
    {
        filename: filename,
        errors: [],
        total: all_rows.length,
        failed: invalid_rows.length,
        success: (all_rows.length - invalid_rows.length),
        invalid_rows: invalid_rows
    }
  end

  def select_invalid_rows_from interns
    interns.select { |intern| intern.errors.count > 0}
  end

  def invalid_headers?
    false
  end

end