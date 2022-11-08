import { api } from "../axios"

class AppRepository {
  async poolsCount() : Promise<Number> {
    const res = await api.get('/pools/count')
    return res.data.count
  }
  async usersCount(): Promise<Number> {
    const res = await api.get('/users/count')
    return res.data.count
  }
  async guessesCount(): Promise<Number> {
    const res = await api.get('/guesses/count')
    return res.data.count
  }
  async createNewPool(title: String) : Promise<String> {
    const res = await api.post('/pools', { title })
    return res.data.code
  } 
}

export { AppRepository }