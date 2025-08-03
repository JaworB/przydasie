const getSleepHours = day => {
  day = day.toLowerCase()
  switch(day) {
    case 'pon':
    return 8
    break;
    case 'wt':
    return 8
    break;
    case 'sr':
    return 8
    break;
    case 'czw':
    return 8
    break;
    case 'pt':
    return 8
    break;
    case 'sb':
    return 8
    break;
    case 'nd':
    return 8
    break; 
  }
}

const getActualSleepHours = () => {
  const actualSleepHours = 
    getSleepHours('pon') +
    getSleepHours('wt') +
    getSleepHours('sr') +
    getSleepHours('czw') +
    getSleepHours('pt') +
    getSleepHours('sb') +
    getSleepHours('nd');
  console.log('W tygodniu przespano: ' + actualSleepHours);
  return actualSleepHours;
}

const getIdealSleepHours = hours => {
  const idealSleepHours = hours * 3;
  console.log('Godzin do idealnego spanka: ' + idealSleepHours);
  return idealSleepHours;
}

const calculateSleepDebt = () => {
  const actualSleepHours = getActualSleepHours();
  const idealSleepHours = getIdealSleepHours(8);
  const diffHours = idealSleepHours - actualSleepHours;

  if(actualSleepHours === idealSleepHours) {
    console.log('eleganckie spanko');
  }
  if(actualSleepHours > idealSleepHours) {
    console.log('za dużo spanka');
    console.log('różnica: ' + diffHours);
  }
  if(actualSleepHours < idealSleepHours){
    console.log('za mało spanka');
    console.log('różnica: ' + diffHours);
  }
}

calculateSleepDebt();
