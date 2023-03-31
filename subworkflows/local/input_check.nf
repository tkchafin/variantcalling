//
// Check input samplesheet and get read channels
//

include { SAMPLESHEET_CHECK } from '../../modules/local/samplesheet_check'

workflow INPUT_CHECK {
    take:
    samplesheet // file: /path/to/samplesheet.csv

    main:
    SAMPLESHEET_CHECK ( samplesheet )
        .csv
        .splitCsv ( header:true, sep:',' )
        .map { [[id: it.sample, type: it.datatype], file(it.datafile), file(it.indexfile)] }
        .set { reads }

    emit:
    reads                                     // channel: [ val(meta), data, index ]
    versions = SAMPLESHEET_CHECK.out.versions // channel: [ versions.yml ]
}
