module GovukMarkdown
  class Renderer < ::Redcarpet::Render::HTML
    def table(header, body)
      <<~HTML
        <table class='govuk-table'>
          <thead class='govuk-table__head'>
            #{header}
          </thead>
          <tbody class='govuk-table__body'>
            #{body}
          </tbody>
        </table>
      HTML
    end

    def table_row(content)
      <<~HTML
        <tr class='govuk-table__row'>
          #{content}
        </tr>
      HTML
    end

    def table_cell(content, _alignment)
      <<~HTML
        <td class='govuk-table__cell'>
          #{content}
        </td>
      HTML
    end

    def header(text, header_level)
      heading_size = case header_level
                     when 1 then "xl"
                     when 2 then "l"
                     when 3 then "m"
                     else "s" end

      id_attribute = @options[:with_toc_data] ? " id=\"#{text.parameterize}\"" : ""

      <<~HTML
        <h#{header_level}#{id_attribute} class="govuk-heading-#{heading_size}">#{text}</h#{header_level}>
      HTML
    end

    def paragraph(text)
      <<~HTML
        <p class="govuk-body-m">#{text}</p>
      HTML
    end

    def list(contents, list_type)
      case list_type
      when :unordered
        <<~HTML
          <ul class="govuk-list govuk-list--bullet">
            #{contents}
          </ul>
        HTML
      when :ordered
        <<~HTML
          <ol class="govuk-list govuk-list--number">
            #{contents}
          </ol>
        HTML
      else
        raise "Unexpected type #{list_type.inspect}"
      end
    end

    def hrule
      <<~HTML
        <hr class="govuk-section-break govuk-section-break--xl govuk-section-break--visible">
      HTML
    end
  end
end
