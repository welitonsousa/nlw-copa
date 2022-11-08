import '../styles/global.css';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

import type { AppProps } from 'next/app'
export default function App({ Component, pageProps }: AppProps) {

  return (
    <div>
      <Component {...pageProps} />
      <ToastContainer theme="dark"/>
    </div>
  )
}
