import { useState, useEffect } from 'react'
import './App.css'


// const isLocal = window.location.hostname === 'localhost' || 
//                 window.location.hostname === '127.0.0.1';

// const API_URL = isLocal
//   ? 'http://localhost:8000/counter'
//   : 'http://backend-service:8000/counter';

const API_URL = 'http://backend-service:8000/counter';

console.log(window.location.hostname)

function App() {
  const [count, setCount] = useState(0)

  const fetchCounter = async () => {
    try {
      const response = await fetch(API_URL)
      const data = await response.json()
      setCount(data.value)
    } catch (error) {
      console.error('Error fetching counter:', error)
    }
  }

  const incrementCounter = async () => {
    try {
      const response = await fetch(`${API_URL}/increment`, {
        method: 'POST'
      })
      const data = await response.json()
      setCount(data.value)
    } catch (error) {
      console.error('Error incrementing counter:', error)
    }
  }

  useEffect(() => {
    fetchCounter()
  }, [])

  return (
    <div style={{ textAlign: 'center', marginTop: '50px' }}>
      <h1>{count}</h1> 
      <button onClick={incrementCounter}>
        Increment
      </button>
    </div>
  )
}

export default App
