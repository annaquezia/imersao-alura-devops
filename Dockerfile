FROM python:3.11-alpine

# define o diretório de trabalho dentro do cointêiner -> define a pasta onde ele está
WORKDIR /app

# copia o arquivo de requisitos e instala as depedências
# Usamos o --no-cache-dir para evitar o cache do pip, reduzindo, assim, o tamanho da imagem
COPY requirements.txt .
RUN apk add --no-cache gcc musl-dev libffi-dev rust cargo \
    && pip install --no-cache-dir -r requirements.txt

# copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# expõe a porta que a aplicaçnao FastAPI irá rodar (a porta padrão é 8000)
EXPOSE 8000

# comando para rodas a aplicação usando uvicorn
# o host 0.0.0.0 permite que a aplicação seja acessível externamente ao contêiner
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
