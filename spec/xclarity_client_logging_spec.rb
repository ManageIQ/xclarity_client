require 'spec_helper'

describe XClarityClient do
  describe '.logger' do
    context 'when no custom logger is set' do
      before do
        # Reset logger to default state
        XClarityClient.logger = nil
      end

      it 'returns a Logger instance' do
        expect(XClarityClient.logger).to be_a(Logger)
      end

      it 'uses IO::NULL as the default output' do
        logger = XClarityClient.logger
        expect(logger.instance_variable_get(:@logdev).dev).to eq(IO::NULL)
      end

      it 'returns the same logger instance on subsequent calls' do
        logger1 = XClarityClient.logger
        logger2 = XClarityClient.logger
        expect(logger1).to be(logger2)
      end
    end

    context 'when a custom logger is set' do
      let(:custom_logger) { Logger.new(STDOUT) }

      before do
        XClarityClient.logger = custom_logger
      end

      after do
        # Reset to default state
        XClarityClient.logger = nil
      end

      it 'returns the custom logger' do
        expect(XClarityClient.logger).to be(custom_logger)
      end

      it 'persists the custom logger across calls' do
        logger1 = XClarityClient.logger
        logger2 = XClarityClient.logger
        expect(logger1).to be(custom_logger)
        expect(logger2).to be(custom_logger)
      end
    end
  end

  describe '.logger=' do
    let(:custom_logger) { Logger.new(STDERR) }

    after do
      # Reset to default state
      XClarityClient.logger = nil
    end

    it 'sets a custom logger' do
      XClarityClient.logger = custom_logger
      expect(XClarityClient.logger).to be(custom_logger)
    end

    it 'allows setting logger to nil' do
      XClarityClient.logger = custom_logger
      XClarityClient.logger = nil
      expect(XClarityClient.logger).to be_a(Logger)
      expect(XClarityClient.logger).not_to be(custom_logger)
    end

    it 'accepts any object that responds to logger methods' do
      mock_logger = double('logger')
      XClarityClient.logger = mock_logger
      expect(XClarityClient.logger).to be(mock_logger)
    end
  end
end
