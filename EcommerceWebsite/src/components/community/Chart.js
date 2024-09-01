import React, { useState } from 'react';
import { Bar, Line } from 'react-chartjs-2';
import 'chart.js/auto';

const styles = {
  container: {
    padding: '20px',
    fontFamily: 'Arial, sans-serif',
  },
  header: {
    textAlign: 'center',
    marginBottom: '20px',
  },
  chartContainer: {
    display: 'flex',
    justifyContent: 'space-around',
    marginBottom: '40px',
  },
  controls: {
    display: 'flex',
    justifyContent: 'center',
    marginBottom: '20px',
  },
  controlButton: {
    padding: '10px 20px',
    margin: '0 10px',
    border: 'none',
    backgroundColor: '#007bff',
    color: '#fff',
    borderRadius: '5px',
    cursor: 'pointer',
  }
};

// Dữ liệu mẫu
const sampleData = {
  monthly: {
    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
    datasets: [
      {
        label: 'Số lượng sản phẩm bán ra',
        data: [300, 250, 200, 300, 400, 350, 300, 500, 450, 400, 350, 300],
        backgroundColor: 'rgba(54, 162, 235, 0.6)',
        borderColor: 'rgba(54, 162, 235, 1)',
        borderWidth: 1,
      }
    ],
  },
  quarterly: {
    labels: ['Q1', 'Q2', 'Q3', 'Q4'],
    datasets: [
      {
        label: 'Số lượng sản phẩm bán ra',
        data: [750, 1050, 1250, 1050],
        backgroundColor: 'rgba(255, 206, 86, 0.6)',
        borderColor: 'rgba(255, 206, 86, 1)',
        borderWidth: 1,
      }
    ],
  },
  yearly: {
    labels: ['2021', '2022', '2023'],
    datasets: [
      {
        label: 'Số lượng sản phẩm bán ra',
        data: [4000, 4500, 5000],
        backgroundColor: 'rgba(75, 192, 192, 0.6)',
        borderColor: 'rgba(75, 192, 192, 1)',
        borderWidth: 1,
      }
    ],
  },
};

const Chart = () => {
  const [view, setView] = useState('monthly');

  const handleChangeView = (newView) => {
    setView(newView);
  };

  return (
    <div style={styles.container}>
      <h1 style={styles.header}>Thống kê bán hàng</h1>
      <div style={styles.controls}>
        <button style={styles.controlButton} onClick={() => handleChangeView('monthly')}>Tháng</button>
        <button style={styles.controlButton} onClick={() => handleChangeView('quarterly')}>Quý</button>
        <button style={styles.controlButton} onClick={() => handleChangeView('yearly')}>Năm</button>
      </div>
      <div style={styles.chartContainer}>
        {view === 'monthly' && <Bar data={sampleData.monthly} />}
        {view === 'quarterly' && <Bar data={sampleData.quarterly} />}
        {view === 'yearly' && <Line data={sampleData.yearly} />}
      </div>
    </div>
  );
};

export default Chart;