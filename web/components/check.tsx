import Image from 'next/image'

interface Props { title: string, subtitle: string }


export default function Check(props: Props) {
  return (
    <div className='flex flex-row gap-4'>
      <Image src={require('../assets/icons/check.svg')} alt="" />
      <div className='flex flex-col'>
        <span className='font-bold text-2xl'>{props.title}</span>
        <span>{props.subtitle}</span>
      </div>
    </div>
  )
}