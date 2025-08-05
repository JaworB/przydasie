let bullshitArrays = [
    ['góraska','pizdorka','chlembek','boczuś'],
    ['na górki','do parku kurde','do domu - kurde pada','do dziadka!'],
    ['łomśem','sznurem','pimkom','smutek żal - pimka pod szafą :(']
]

function coChceBombusz(){
    let selectFirst = (Math.floor(Math.random() * bullshitArrays.length))
    let selectItem = (Math.floor(Math.random() * bullshitArrays[selectFirst].length))
    switch (selectFirst) {
        case 0:
            console.log(`Bombusz chętnie zjadłby ${bullshitArrays[selectFirst][selectItem]}`)
        break;
        case 1:
            console.log(`Bombusz chętnie wybrałby się ${bullshitArrays[selectFirst][selectItem]}`)
        break;
        case 2:
            console.log(`Kurdebele, ale pobawiłbym się ${bullshitArrays[selectFirst][selectItem]}`)
        break;
    }
}

coChceBombusz();
