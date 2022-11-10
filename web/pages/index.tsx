import Image from 'next/image'
import { FormEvent, useEffect, useState } from 'react';
import Check from '../components/check'
import { AppRepository } from '../lib/repositories/appRepository';
import { toast, TypeOptions } from 'react-toastify';
import { GetStaticProps } from 'next'

interface Props { poolsCount: number, usersCount: number, guessesCount: number }
const repo = new AppRepository()
const notify = (title: String, type: TypeOptions) => toast(title, {type});

export default function Home(props: Props) {

  const [poolsCount, setPoolCount] = useState(props.poolsCount)
  const [poolTitle, setPoolTitle] = useState('')

  const registerPool = async (event: FormEvent) => {
    try{
      event.preventDefault()
      if (!poolTitle) throw 'invalid title' 
      const code = await repo.createNewPool(poolTitle)
      notify(`Código: ${code}`, 'success')
      await navigator.clipboard.writeText(`${code}`)
      setTimeout(() => {
        notify('O código foi copiado para sua area de transferência', 'success')
      }, 700)
      setPoolCount(poolsCount + 1)
      setPoolTitle('')
    }catch(err){
      console.log(err);
      notify('Não foi possível criar este bolão', 'error')
    }
  }

  useEffect(() => {
    setPoolCount(props.poolsCount)
  }, [props.poolsCount])


  return (
    <div className='max-w-[1124px] mx-auto grid grid-cols-2 gap-28 items-center h-screen text-white p-4 max-md:grid-cols-1'>
      <main>
        <Image src={require('../assets/images/logo-yellow.svg')} alt="" />
        <h1 className='mt-12 text-[56px] font-bold leading-tight'>Crie seu próprio bolão da copa e compartilhe entre amigos!</h1>
        <div className='flex grid-flow-row items-center mt-6'>
          <Image src={require('../assets/images/avatares.png')} alt="" />
          <strong >
            <span className='text-green-500 mx-2'>
              + {props.usersCount || '0'}
            </span>
            pessoas já estão usando
          </strong>
        </div>
        <form className='mt-6 flex gap-2 w-full h-14' onSubmit={registerPool}>
          <input
            type="text"
            className='w-2/3 h-full rounded-md bg-[#202024] px-4'
            placeholder='Qual nome do seu bolão?'
            value={poolTitle}
            onChange={event => setPoolTitle(event.target.value)}
            required />
          <button
            className='w-1/3 bg-[#F7DD43] h-full text-black rounded-md uppercase'>
            Criar meu bolão
          </button>
        </form>
        <p className='mt-6 text-grey-1000'>Após criar seu bolão, você receberá um código único que poderá usar para convidar outras pessoas 🚀</p>
        <hr className='mt-6 border-grey-1000' />
        <div className='mt-6 flex justify-between'>
          <Check title={`+${poolsCount}`} subtitle='Bolões criados' />
          <div className='justify-self-center mx-4'>
            <div className='h-full bg-grey-1000 w-[1px] '></div>
          </div>
          <Check title={`+ ${props.guessesCount}`} subtitle='Palpites enviados' />
        </div>
      </main>
      <Image src={require('../assets/images/phones.png')} alt="" quality={100} />
    </div>
  )
}

// getServerSideProps
// getStaticProps

export const getStaticProps = async () => {
  const res = await Promise.all([repo.poolsCount(), repo.usersCount(), repo.guessesCount()])
  return {
    props: {
      poolsCount: res[0], usersCount: res[1], guessesCount: res[2],
    },
    revalidate: 60 * 30, // 30 minutes
  }

}